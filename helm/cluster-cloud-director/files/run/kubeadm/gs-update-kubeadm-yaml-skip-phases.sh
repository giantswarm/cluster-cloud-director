#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
readonly dir

# Run this script only if this is the init node.
if [[ ! -f ${dir}/kubeadm.yaml ]]; then
    exit 0
fi

# This will add the configuration below to "InitConfiguration":
#
#     skipPhases: ["addon/coredns", "addon/kube-proxy"]
#
set -x
sed -i 's/nodeRegistration:/skipPhases: ["addon\/coredns", "addon\/kube-proxy"]\nnodeRegistration:/' "${dir}/kubeadm.yaml"
{ set +x; } 2>/dev/null
