{{/*
Generates template spec for worker machines.
*/}}
{{- define "worker-vcdmachinetemplate-spec" -}}
{{- $pool := $.nodePool.config | deepCopy -}}
{{- $pool = set $pool "diskSize" ( include "calculateDiskBytes" $pool.diskSizeGB ) -}}
{{- $pool = unset $pool "diskSizeGB" -}}
{{- $pool = unset $pool "replicas" -}}
{{- $pool = unset $pool "machineHealthCheck" -}}
{{- $pool = unset $pool "customNodeLabels" -}}
{{- $pool = unset $pool "customNodeTaints" -}}

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

{{/*
Takes an array of maps containing worker nodePools and adds each map to a new
map. Results in a map of node specs which can be iterated over to create
MachineDeployments. Used when templating VCDMachineTemplates.
*/}}
{{ define "createMapOfWorkerPoolSpecs" -}}
{{- $nodeMap := dict -}}
{{- range $index, $pool := .Values.global.nodePools | default .Values.cluster.providerIntegration.workers.defaultNodePools -}}
  {{- $_ := set $nodeMap $index $pool -}}
{{- end -}}
{{ toYaml $nodeMap }}
{{- end }}