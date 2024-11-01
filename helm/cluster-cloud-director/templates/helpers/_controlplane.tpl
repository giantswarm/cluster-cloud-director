{{/*
Generates template spec for controlplane machines.
*/}}
{{- define "controlplane-vcdmachinetemplate-spec" -}}
{{- $pool := $.Values.global.controlPlane.machineTemplate | deepCopy -}}
{{- $pool = set $pool "diskSize" ( include "calculateDiskBytes" $pool.diskSizeGB ) -}}
{{- $pool = unset $pool "diskSizeGB" -}}

{{- $osName := include "cluster.os.name" $ }}
{{- $osReleaseChannel := include "cluster.os.releaseChannel" $ }}
{{- $osVersion := include "cluster.os.version" $ }}
{{- $kubernetesVersion := include "cluster.component.kubernetes.version" $ }}
{{- $osToolingVersion := include "cluster.os.tooling.version" $ }}

{{- /* Modify $pool.template here */ -}}
{{- $templateValue := printf "%s-%s-%s-kube-%s-tooling-%s-gs" $osName $osReleaseChannel $osVersion $kubernetesVersion $osToolingVersion -}}
{{- $_ := set $pool "template" $templateValue -}}

{{- $pool | toYaml }}
vmNamingTemplate: {{ $.Values.global.providerSpecific.vmNamingTemplate }}
{{- if $.Values.global.connectivity.network.extraOvdcNetworks }}
extraOvdcNetworks:
  {{- range $.Values.global.connectivity.network.extraOvdcNetworks }}
  - {{ . }}
  {{- end }}
{{- end -}}
{{- end -}}
