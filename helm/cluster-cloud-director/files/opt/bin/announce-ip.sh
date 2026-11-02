#!/usr/bin/env bash

# Send unsolicited ARP for this node's IPv4 address(es) so the gateway and other
# neighbours replace stale IP->MAC entries left behind by a previously removed VM
# that used the same IP (e.g. node replacement during cluster upgrades).

# Exit on error.
set -o errexit -o nounset -o pipefail

# This variable seems hard-coded, but it's getting rendered by cluster-cloud-director's `internal.unsolicitedArp.enabled` value.
enabled={{ .Values.internal.unsolicitedArp.enabled | default false | ternary "true" "false" | quote }}

if ${enabled}
then
  # Check arping.
  if ! command -v arping &> /dev/null
  then
    echo "arping not found, skipping unsolicited ARP."
    exit 0
  fi

  # Define default route interface.
  interface=""

  # Retry 60 times.
  for _ in $(seq 1 60)
  do
    # Retrieve default route interface.
    interface="$(ip -4 route show default | awk '!found { for (i=1; i<=NF; i++) if ($i == "dev") { print $(i+1); found=1; break } }')"

    # Check default route interface.
    if [ -n "${interface}" ]
    then
      # Default route interface found: Continue.
      break
    fi

    # No default route interface found: Retry.
    sleep 1
  done

  # Check default route interface.
  if [ -z "${interface}" ]
  then
    echo "No default route interface found, skipping unsolicited ARP."
    exit 0
  fi

  # Get default route interface's addresses.
  # shellcheck disable=SC2207 # IPv4 addresses contain no whitespace or glob characters.
  addresses=($(ip -4 -o addr show dev "${interface}" scope global | awk '{ split($4, cidr, "/"); print cidr[1] }'))

  # Check addresses.
  if [ "${#addresses[@]}" -eq 0 ]
  then
    echo "No IPv4 addresses found on interface '${interface}', skipping unsolicited ARP."
    exit 0
  fi

  # Iterate addresses.
  for address in "${addresses[@]}"
  do
    # Announce address.
    echo "Announcing address '${address}' on interface '${interface}'."

    # ARP request form (-U) and ARP reply form (-A): Some devices only honour one of them.
    arping -U -I "${interface}" "${address}" -c 3 || echo "arping -U for address '${address}' on interface '${interface}' failed."
    arping -A -I "${interface}" "${address}" -c 3 || echo "arping -A for address '${address}' on interface '${interface}' failed."
  done

  exit 0
else
  echo "Unsolicited ARP is disabled (internal.unsolicitedArp.enabled: false), exiting."
  exit 0
fi
