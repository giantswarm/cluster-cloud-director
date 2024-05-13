# The helper functions here can be called in templates and _helpers.tpl
# This file should be self-sufficient. Don't call any functions from _helpers.tpl

{{- define "ntpFiles" -}}
{{- if or $.Values.global.connectivity.ntp.pools $.Values.global.connectivity.ntp.servers -}}
- path: /etc/chrony/chrony.conf
  permissions: "0644"
  content: |
    {{- range $.Values.global.connectivity.ntp.pools }}
    pool {{.}} iburst
    {{- end }}

    {{- range $.Values.global.connectivity.ntp.servers }}
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
{{- if or $.Values.global.connectivity.ntp.pools $.Values.global.connectivity.ntp.servers }}
- systemctl daemon-reload
- systemctl restart chrony
{{- end -}}
{{- end -}}

{{- define "ntpIgnition" -}}
{{- with $.Values.global.connectivity.ntp }}
{{- if or .pools .servers -}}
- path: /etc/systemd/timesyncd.conf
  mode: 0644
  contents:
    inline: |
      [Time]
      {{- if and .pools .servers }}
      NTP={{ join " " .pools }} {{ join " " .servers }}
      {{- else if .pools }}
      NTP={{ join " " .pools }}
      {{- else }}
      NTP={{ join " " .servers }}
      {{- end }}
{{- end -}}
{{- end }}
{{- end }}
