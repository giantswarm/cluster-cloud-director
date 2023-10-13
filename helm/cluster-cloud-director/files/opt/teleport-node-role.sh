#!/bin/bash

# This script is executed by Teleport dynamic label configuration to assign the K8s role 
# for the node (control-plane or worker)

if systemctl is-active --quiet kubelet.service; then
    if [ -e "/etc/kubernetes/manifests/kube-apiserver.yaml" ]; then
        echo "control-plane"
    else
        echo "worker"
    fi
else
    echo ""
fi
