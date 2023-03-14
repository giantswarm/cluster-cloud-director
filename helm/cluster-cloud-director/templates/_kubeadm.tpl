# The helper functions here can be called in templates and _helpers.tpl
# This file should be self-sufficient. Don't call any functions from _helpers.tpl

{{- define "kubeadmFiles" -}}
- path: /var/run/kubeadm/gs-update-kubeadm-yaml-skip-kube-proxy.sh
  permissions: "0700"
  content: |
    {{- .Files.Get "files/var/run/kubeadm/gs-update-kubeadm-yaml-skip-kube-proxy.sh" | nindent 4 }}
- path: /var/run/kubeadm/gs-kube-proxy-config.yaml
  permissions: "0600"
  content: |
    {{- .Files.Get "files/var/run/kubeadm/gs-kube-proxy-config.yaml" | nindent 4 }}
- path: /var/run/kubeadm/gs-kube-proxy-patch.sh
  permissions: "0700"
  content: |
    {{- .Files.Get "files/var/run/kubeadm/gs-kube-proxy-patch.sh" | nindent 4 }}
{{- end -}}
