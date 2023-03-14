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

# TODO Change to giantswarm/yq # (https://github.com/giantswarm/retagger/pull/810)
readonly IMAGE="mikefarah/yq:4.31.2"
readonly yq_flags=(run --rm -v "${PWD}:/workdir" "${IMAGE}")
readonly YQ="docker ${yq_flags[*]}"

set -x

docker pull "${IMAGE}"

cd "${dir}"

# This will add the configuration below to "InitConfiguration":
#
#     skipPhases:
#       - addon/kube-proxy
#
$YQ e -i '(select(.kind == "InitConfiguration")).skipPhases += ["addon/kube-proxy"]' kubeadm.yaml

{ set +x; } 2>/dev/null
