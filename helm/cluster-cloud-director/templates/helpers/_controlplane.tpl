{{/*
Generates template spec for controlplane machines.
*/}}
{{- define "controlplane-vcdmachinetemplate-spec" -}}
{{- $pool := $.Values.global.controlPlane.machineTemplate | deepCopy -}}
{{- $pool = set $pool "diskSize" ( include "calculateDiskBytes" $pool.diskSizeGB ) -}}
{{- $pool = unset $pool "diskSizeGB" -}}

{{- if $pool }}
{{- $pool | toYaml }}
{{- end }}
vmNamingTemplate: {{ $.Values.global.providerSpecific.vmNamingTemplate }}
{{- if $.Values.global.connectivity.network.extraOvdcNetworks }}
extraOvdcNetworks:
  {{- range $.Values.global.connectivity.network.extraOvdcNetworks }}
  - {{ . }}
  {{- end }}
{{- end -}}
{{- end -}}
