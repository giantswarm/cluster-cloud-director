# The helper functions here can be called in templates and _helpers.tpl
# This file should be self-sufficient. Don't call any functions from _helpers.tpl


{{- define "sshFiles" -}}
{{- if $.Values.ssh.trustedCaKeys -}}
- path: /etc/ssh/trusted-user-ca-keys.pem
  permissions: "0600"
  content: |
    {{- range $.Values.ssh.trustedCaKeys}}
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
{{- if $.Values.ssh.users -}}
users:
{{- range $.Values.ssh.users }}
- name: {{ .name }}
{{- if .sudo }}
  sudo: {{ .sudo }}
{{- end }}
{{- if .authorizedKeys }}
  sshAuthorizedKeys:
  {{- range .authorizedKeys }}
  - {{ . }}
  {{- end }}
{{- end }}
{{- end -}}
{{- end }}
{{- end -}}
