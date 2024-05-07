# The helper functions here can be called in templates and _helpers.tpl
# This file should be self-sufficient. Don't call any functions from _helpers.tpl


{{- define "sshFiles" -}}
{{- if $.Values.global.connectivity.shell.sshTrustedUserCAKeys -}}
- path: /etc/ssh/trusted-user-ca-keys.pem
  permissions: "0600"
  content: |
    {{- range $.Values.global.connectivity.shell.sshTrustedUserCAKeys }}
    {{.}}
    {{- end }}
- path: /etc/ssh/sshd_config
  permissions: "0600"
  content: |
    {{- .Files.Get "files/etc/ssh/sshd_config" | nindent 4 }}
{{- end -}}
{{- end }}

{{- define "sshPostKubeadmCommands" -}}
- systemctl restart sshd
{{- end -}}

{{- define "sshUsers" -}}
{{- if $.Values.global.connectivity.shell.osUsers -}}
users:
  {{- $.Values.global.connectivity.shell.osUsers | toYaml | nindent 2 }}
{{- end }}
{{- end -}}
