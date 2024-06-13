#!/bin/bash

if systemctl is-active --quiet kubelet.service; then
    if [ -e "/etc/kubernetes/manifests/kube-apiserver.yaml" ]; then
        echo "control-plane"
    else
        echo "worker"
    fi
else
    echo ""
fi
