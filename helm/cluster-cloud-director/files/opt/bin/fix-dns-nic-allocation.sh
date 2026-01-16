#!/bin/bash
# Script to align DNS server configuration with routing table
# Ensures DNS servers are configured on the interface that routes to them
# Removes DNS from interfaces that should not have them

set -e

# Wait for networkd restart after static routes unit
sleep 3

# Get all DNS servers from all interfaces
DNS_SERVERS=$(cat /etc/systemd/network/* | sed -n 's/^DNS=//p' | sort -u)

if [ -z "$DNS_SERVERS" ]; then
    echo "No DNS servers found configured."
    exit 0
fi

echo "Found DNS servers:"
echo "$DNS_SERVERS"
echo ""

# For each DNS server, find the routing interface
declare -A DNS_TO_INTERFACE

for dns_ip in $DNS_SERVERS; do
    echo "Checking route to $dns_ip..."
    
    # Get the interface from ip route
    route_info=$(ip route get $dns_ip 2>/dev/null || echo "")
    
    if [ -z "$route_info" ]; then
        echo "  WARNING: No route found for $dns_ip"
        continue
    fi
    
    # Extract the interface name
    interface=$(echo "$route_info" | grep -oP "dev \K[^ ]+" | head -1)
    
    if [ -z "$interface" ]; then
        echo "  WARNING: Could not determine interface for $dns_ip"
        continue
    fi
    
    echo "  Route goes through interface: $interface"
    
    # Store the mapping
    if [ -z "${DNS_TO_INTERFACE[$interface]}" ]; then
        DNS_TO_INTERFACE[$interface]=$dns_ip
    else
        DNS_TO_INTERFACE[$interface]="${DNS_TO_INTERFACE[$interface]} $dns_ip"
    fi
done

echo "=== DNS-to-Interface Mapping ==="
for iface in "${!DNS_TO_INTERFACE[@]}"; do
    echo "Interface $iface should have DNS: ${DNS_TO_INTERFACE[$iface]}"
done

echo "=== Processing All Network Files ==="

# Process all network files
for network_file in /etc/systemd/network/*.network; do
    [ -f "$network_file" ] || continue
    
    basename=$(basename "$network_file")
    echo ""
    echo "File: $basename"
    
    # Get the interface name for this file via networkctl
    iface=""
    for possible_iface in $(networkctl list --no-legend | awk "{print \$2}"); do
        iface_netfile=$(networkctl status $possible_iface 2>/dev/null | grep "Network File:" | awk "{print \$3}")
        if [ "$iface_netfile" = "$network_file" ]; then
            iface=$possible_iface
            break
        fi
    done
    
    if [ -z "$iface" ]; then
        echo "  Cannot determine interface, skipping"
        continue
    fi
    
    echo "  Interface: $iface"
    
    # Determine if this interface should have DNS servers
    should_have_dns="${DNS_TO_INTERFACE[$iface]}"
    has_dns=$(grep -c "^DNS=" "$network_file" 2>/dev/null || echo "0")
    
    if [ -n "$should_have_dns" ]; then
        echo "  Action: ADD/UPDATE DNS servers"
        
        # Backup
        cp "$network_file" "${network_file}.backup-$(date +%Y%m%d-%H%M%S)"
        
        # Remove existing DNS entries
        sed -i "/^DNS=/d" "$network_file"
        
        # Add correct DNS servers after [Network] section
        if grep -q "^\[Network\]" "$network_file"; then
            # Insert after [Network], in reverse order so they appear in correct order
            dns_array=($should_have_dns)
            for ((i=${#dns_array[@]}-1; i>=0; i--)); do
                sed -i "/^\[Network\]/a DNS=${dns_array[i]}" "$network_file"
            done
        else
            # Create [Network] section
            echo "" >> "$network_file"
            echo "[Network]" >> "$network_file"
            for dns_ip in $should_have_dns; do
                echo "DNS=$dns_ip" >> "$network_file"
            done
        fi
        
        echo "  Added DNS: $should_have_dns"
    elif [ "$has_dns" != "0" ]; then
        echo "  Action: REMOVE DNS servers (interface should not have them)"
        
        # Backup
        cp "$network_file" "${network_file}.backup-$(date +%Y%m%d-%H%M%S)"
        
        # Remove DNS entries
        sed -i "/^DNS=/d" "$network_file"
        echo "  Removed $has_dns DNS entries"
    else
        echo "  Action: No change needed"
    fi
done

echo "Restart systemd-networkd to apply changes"
systemctl restart systemd-networkd
sleep 3

echo "Current DNS configuration per interface:"
resolvectl dns