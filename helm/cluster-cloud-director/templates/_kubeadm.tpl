# The helper functions here can be called in templates and _helpers.tpl
# This file should be self-sufficient. Don't call any functions from _helpers.tpl

{{- define "kubeadmFiles" -}}
- path: /run/kubeadm/gs-update-kubeadm-yaml-skip-phases.sh
  permissions: "0700"
  content: |
    {{- .Files.Get "files/run/kubeadm/gs-update-kubeadm-yaml-skip-phases.sh" | nindent 4 }}
{{- end -}}
