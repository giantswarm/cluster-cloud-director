#!/bin/bash
# Script to align DNS server configuration with routing table
# Ensures DNS servers are configured on the interface that routes to them
# Removes DNS from interfaces that should not have them

set -e

# Wait for networkd restart after /opt/bin/set-networkd-units.sh
sleep 3

# Get all DNS servers from all interfaces
DNS_SERVERS=$(cat /etc/systemd/network/* | sed -n 's/^DNS=//p' | sort -u)

if [ -z "$DNS_SERVERS" ]; then
    echo "No DNS servers found configured."
    exit 0
fi

echo "DNS servers: \n$DNS_SERVERS"

# For each DNS server, find the routing interface
declare -A DNS_TO_INTERFACE
declare -A ALL_DNS_SERVERS_MAP

for dns_ip in $DNS_SERVERS; do
    echo "Checking route to $dns_ip..."
    ALL_DNS_SERVERS_MAP[$dns_ip]=1
    
    # Get the interface from ip route
    route_info=$(ip route get $dns_ip 2>/dev/null || echo "")
    
    if [ -z "$route_info" ]; then
        echo "  WARNING: No route found for $dns_ip"
        continue
    fi
    
    # Extract the interface name (look for "dev <interface>")
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

echo "\n=== DNS-to-Interface Mapping ==="
for iface in "${!DNS_TO_INTERFACE[@]}"; do
    echo "Interface $iface should have DNS: ${DNS_TO_INTERFACE[$iface]}"
done

echo \n"=== Processing All Network Files ==="

# Get all network files
for network_file in /etc/systemd/network/*.network; do
    [ -f "$network_file" ] || continue
    
    # Get the interface name for this file
    iface=$(grep -h "^Name=" "$network_file" 2>/dev/null | cut -d= -f2)
    if [ -z "$iface" ]; then
        # Try to find interface by MAC address match
        mac=$(grep "^MACAddress=" "$network_file" 2>/dev/null | cut -d= -f2)
        if [ -n "$mac" ]; then
            iface=$(ip -o link | grep -i "$mac" | awk -F: "{print \$2}" | tr -d " ")
        fi
    fi
    
    if [ -z "$iface" ]; then
        echo "Cannot determine interface for $network_file, skipping"
        continue
    fi
    
    echo "\nProcessing $network_file (interface: $iface)..."
    
    # Check if this file currently has DNS entries
    if ! grep -q "^DNS=" "$network_file" 2>/dev/null; then
        echo "  No DNS entries in this file, skipping"
        continue
    fi
    
    # Check if this interface should have DNS servers
    if [ -n "${DNS_TO_INTERFACE[$iface]}" ]; then
        echo "  This interface SHOULD have DNS servers"
        
        # Backup the file
        cp "$network_file" "${network_file}.backup-$(date +%Y%m%d-%H%M%S)"
        echo "  Backup created"
        
        # Remove existing DNS entries
        sed -i "/^DNS=/d" "$network_file"
        
        # Add the correct DNS servers
        if grep -q "^\[Network\]" "$network_file"; then
            for dns_ip in ${DNS_TO_INTERFACE[$iface]}; do
                sed -i "/^\[Network\]/a DNS=$dns_ip" "$network_file"
            done
        else
            echo "" >> "$network_file"
            echo "[Network]" >> "$network_file"
            for dns_ip in ${DNS_TO_INTERFACE[$iface]}; do
                echo "DNS=$dns_ip" >> "$network_file"
            done
        fi
        
        echo "  Added DNS servers: ${DNS_TO_INTERFACE[$iface]}"
    else
        echo "  This interface should NOT have DNS servers (removing them)"
        
        # Backup the file
        cp "$network_file" "${network_file}.backup-$(date +%Y%m%d-%H%M%S)"
        echo "  Backup created"
        
        # Remove DNS entries
        sed -i "/^DNS=/d" "$network_file"
        echo "  Removed DNS entries"
    fi
    
    echo "  Updated configuration:"
    cat "$network_file" | sed "s/^/    /"
done