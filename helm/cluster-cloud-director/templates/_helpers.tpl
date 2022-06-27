# TEMPLATE-APP: This is set as a reasonable default, feel free to change.

{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "name" -}}
{{- .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "infrastructureApiVersion" -}}
infrastructure.cluster.x-k8s.io/v1beta1
{{- end -}}

{{/*
Common labels
*/}}
{{- define "labels.common" -}}
app: {{ include "name" . | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service | quote }}
app.kubernetes.io/version: {{ .Chart.Version | quote }}
cluster.x-k8s.io/cluster-name: {{ include "resource.default.name" . | quote }}
giantswarm.io/cluster: {{ include "resource.default.name" . | quote }}
giantswarm.io/organization: {{ .Values.cluster.organization | quote }}
application.giantswarm.io/team: {{ index .Chart.Annotations "application.giantswarm.io/team" | quote }}
helm.sh/chart: {{ include "chart" . | quote }}
{{- end -}}

{{/*
Create a prefix for all resource names.
*/}}
{{- define "resource.default.name" -}}
{{ .Values.cluster.name }}
{{- end -}}

{{- define "kubeletExtraArgs" -}}
{{- .Files.Get "files/kubelet-args" -}}
{{- end -}}

{{/*
Updates in KubeadmConfigTemplate will not trigger any rollout for worker nodes.
It is necessary to create a new template with a new name to trigger an upgrade.
See https://github.com/kubernetes-sigs/cluster-api/issues/4910
See https://github.com/kubernetes-sigs/cluster-api/pull/5027/files
*/}}
{{- define "kubeAdmConfigTemplateRevision" -}}
{{- $inputs := (dict
  "users" .Values.kubeadm.users
  "kubeletExtraArgs" (include "kubeletExtraArgs" .) ) }}
{{- mustToJson $inputs | toString | quote | sha1sum | trunc 8 }}
{{- end -}}

{{/*
VCDMachineTemplate is immutable. We need to create new versions during upgrades.
Here we are generating a hash suffix to trigger upgrade when only it is necessary by
using only the parameters used in vcdmachinetemplate.yaml.
*/}}
{{- define "mtRevision" -}}
{{- $inputs := (dict
  "catalog" .catalog
  "template" .template
  "sizingPolicy" .sizingPolicy
  "placementPolicy" .placementPolicy
  "storageProfile" .storageProfile
  "infrastructureApiVersion" ( include "infrastructureApiVersion" . )
  "name" .name ) }}
{{- mustToJson $inputs | toString | quote | sha1sum | trunc 8 }}
{{- end -}}

{{- define "mtRevisionByClass" -}}
{{- $outerScope := . }}
{{- range .Values.nodeClasses }}
{{- if eq .name $outerScope.class }}
{{- include "mtRevision" . }}
{{- end }}
{{- end }}
{{- end -}}

{{- define "mtRevisionOfControlPlane" -}}
{{- $outerScope := . }}
{{- include "mtRevision" (set (merge $outerScope .Values.controlPlane) "name" "control-plane") }}
{{- end -}}
