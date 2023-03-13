# The helper functions here can be called in templates and _helpers.tpl
# This file should be self-sufficient. Don't call any functions from _helpers.tpl


{{- define "ntpFiles" -}}
{{- if or $.Values.ntp.pools $.Values.ntp.servers -}}
- path: /etc/chrony/chrony.conf
  permissions: "0644"
  content: |
    {{- range $.Values.ntp.pools}}
    pool {{.}} iburst
    {{- end }}

    {{- range $.Values.ntp.servers}}
    server {{.}} iburst
    {{- end }}

    keyfile /etc/chrony/chrony.keys

    driftfile /var/lib/chrony/chrony.drift

    logdir /var/log/chrony

    maxupdateskew 100.0

    rtcsync

    makestep 1 3
{{- end -}}
{{- end }}

{{- define "ntpPostKubeadmCommands" -}}
{{- if or $.Values.ntp.pools $.Values.ntp.servers -}}
- systemctl daemon-reload
- systemctl restart chrony
{{- end -}}
{{- end -}}
