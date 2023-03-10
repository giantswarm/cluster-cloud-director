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
Common labels without kubernetes version
https://github.com/giantswarm/giantswarm/issues/22441
*/}}
{{- define "labels.selector" -}}
app: {{ include "name" . | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service | quote }}
cluster.x-k8s.io/cluster-name: {{ include "resource.default.name" . | quote }}
giantswarm.io/cluster: {{ include "resource.default.name" . | quote }}
giantswarm.io/organization: {{ .Values.organization | quote }}
application.giantswarm.io/team: {{ index .Chart.Annotations "application.giantswarm.io/team" | quote }}
{{- end -}}

{{/*
Common labels with kubernetes version
https://github.com/giantswarm/giantswarm/issues/22441
*/}}
{{- define "labels.common" -}}
{{- include "labels.selector" . }}
app.kubernetes.io/version: {{ $.Chart.Version | quote }}
helm.sh/chart: {{ include "chart" . | quote }}
{{- end -}}

{{/*
Create a prefix for all resource names.
*/}}
{{- define "resource.default.name" -}}
{{ .Release.Name }}
{{- end -}}

{{- define "securityContext.runAsUser" -}}
1000
{{- end -}}
{{- define "securityContext.runAsGroup" -}}
1000
{{- end -}}

{{- define "kubeletExtraArgs" -}}
{{- .Files.Get "files/kubelet-args" -}}
{{- end -}}

{{/*
use the cluster-apps-operator created secret <clusterName>-cluster-values as default
*/}}
{{- define "containerdProxySecret" -}}
{{- $defaultContainerdProxySecret := printf "%s-systemd-proxy" (include "resource.default.name" . ) -}}
{{ .Values.proxy.secretName | default $defaultContainerdProxySecret }}
{{- end -}}

{{- define "containerdProxyConfig" -}}
- path: /etc/systemd/system/containerd.service.d/99-http-proxy.conf
  permissions: "0600"
  contentFrom:
    secret:
      name: {{ include "containerdProxySecret" $ }}
      key: containerdProxy   
{{- end -}}

{{- define "staticRoutes" -}}
- path: /etc/systemd/system/static-routes.service
  permissions: "0644"
  content: |
    [Unit]
    Description=A oneshot service that creates static routes specified in cluster values.
    After=network-online.target
    Wants=network-online.target
    [Install]
    WantedBy=multi-user.target    
    [Service]
    Type=oneshot
    RemainAfterExit=yes
    {{- range $.Values.network.staticRoutes}}
    ExecStart=/bin/bash -c "ip route add {{ .destination }} via {{ .via }}"
    {{- end -}}
{{- end }}

{{- define "kubeProxyFiles" }}
- path: /run/kubeadm/gs-kube-proxy-config.yaml
  permissions: "0600"
  content: |
    {{- .Files.Get "files/etc/gs-kube-proxy-config.yaml" | nindent 4 }}
- path: /run/kubeadm/gs-kube-proxy-patch.sh
  permissions: "0700"
  content: |
    {{- .Files.Get "files/etc/gs-kube-proxy-patch.sh" | nindent 4 }}
{{- end -}}

{{/*
Updates in KubeadmConfigTemplate will not trigger any rollout for worker nodes.
It is necessary to create a new template with a new name to trigger an upgrade.
See https://github.com/kubernetes-sigs/cluster-api/issues/4910
See https://github.com/kubernetes-sigs/cluster-api/pull/5027/files
*/}}
{{- define "kubeadmConfigTemplateSpec" -}}

{{- include "sshUsers" . }}

joinConfiguration:
  nodeRegistration:
    criSocket: /run/containerd/containerd.sock
    kubeletExtraArgs:
      {{- include "kubeletExtraArgs" . | nindent  6 -}}
      node-labels: "giantswarm.io/node-pool={{ .pool.name }},{{- include "labelsByClass" . -}}"
    {{- include "taintsByClass" . | nindent  4}}

files:
{{- include "ntpFiles" . | nindent 2}}
{{- include "sshFiles" . | nindent 2}}
{{- include "registryFiles" . | nindent 2 }}
{{- if $.Values.proxy.enabled }}
{{- include "containerdProxyConfig" . | nindent 2}}
{{- end }}
{{- if $.Values.network.staticRoutes }}
{{- include "staticRoutes" . | nindent 2}}
{{- end }}

preKubeadmCommands:
{{- if $.Values.proxy.enabled }}
- systemctl daemon-reload
- systemctl restart containerd
{{- end }}
{{- if $.Values.network.staticRoutes }}
- systemctl daemon-reload
- systemctl enable --now static-routes.service
{{- end }}

postKubeadmCommands:
{{ include "sshPostKubeadmCommands" . }}
{{ include "ntpPostKubeadmCommands" . }}
{{- end -}}

{{- define "kubeadmConfigTemplateRevision" -}}
{{- $inputs := (dict
  "data" (include "kubeadmConfigTemplateSpec" .) ) }}
{{- mustToJson $inputs | toString | quote | sha1sum | trunc 8 }}
{{- end -}}

{{/*
VCDMachineTemplate is immutable. We need to create new versions during upgrades.
Here we are generating a hash suffix to trigger upgrade when only it is necessary by
using only the parameters used in vcdmachinetemplate.yaml.
diskSize is computed with 1024^3 instead of 1000^3 because of https://github.com/vmware/cluster-api-provider-cloud-director/blob/501b616011dced31ddf3e0e3da0036a7a49ce015/controllers/vcdmachine_controller.go#L651
*/}}

{{- define "mtSpec" -}}
catalog: {{ .currentClass.catalog }}
template: {{ .currentClass.template }}
sizingPolicy: {{ .currentClass.sizingPolicy }}
placementPolicy: {{ .currentClass.placementPolicy }}
storageProfile: {{ .currentClass.storageProfile }}
diskSize: {{ mul .currentClass.diskSizeGB 1024 1024 1024}}
vmNamingTemplate: {{ $.vmNamingTemplate }}
{{- if $.network.extraOvdcNetworks }}
extraOvdcNetworks:
  {{- range $.network.extraOvdcNetworks }}
  - {{ . }}
  {{- end }}
{{- end -}}
{{- end -}}

{{- define "taints" -}}
{{- with . -}}
taints:
{{- range . }}
- key: {{ .key | quote }}
  value: {{ .value | quote }}
  effect: {{ .effect | quote }}
{{- end }}
{{- end }}
{{- end -}}

{{- define "mtRevision" -}}
{{- $inputs := (dict
  "spec" (include "mtSpec" .)
  "infrastructureApiVersion" ( include "infrastructureApiVersion" . ) ) }}
{{- mustToJson $inputs | toString | quote | sha1sum | trunc 8 }}
{{- end -}}

{{- define "mtRevisionByClass" -}}
{{- $outerScope := . }}
{{- range $name, $value := .currentValues.nodeClasses }}
{{- if eq $name $outerScope.class }}
{{- include "mtRevision" (merge (dict "currentClass" $value) $outerScope.currentValues) }}
{{- end }}
{{- end }}
{{- end -}}

{{- define "taintsByClass" -}}
{{- $outerScope := . }}
{{- range $name, $value := .Values.nodeClasses }}
{{- if eq $name $outerScope.pool.class }}
{{- include "taints" $value.customNodeTaints }}
{{- end }}
{{- end }}
{{- end -}}

{{- define "labelsByClass" -}}
{{- $outerScope := . }}
{{- range $name, $value := .Values.nodeClasses }}
{{- if eq $name $outerScope.pool.class }}
{{- join "," $value.customNodeLabels -}}
{{- end }}
{{- end }}
{{- end -}}

{{- define "mtRevisionByControlPlane" -}}
{{- $outerScope := . }}
{{- include "mtRevision" (merge (dict "currentClass" .Values.controlPlane) $outerScope.Values) }}
{{- end -}}

{{/*
Generate a stanza for KubeAdmConfig and KubeAdmControlPlane in order to 
mount containerd configuration for registry configuration in nodes.
*/}}
{{- define "registryFiles" -}}
{{- if and .Values.connectivity .Values.connectivity.containerRegistries -}}
- path: /etc/containerd/conf.d/registry-config.toml
  permissions: "0600"
  contentFrom:
    secret:
      name: {{ include "registrySecretName" $ }}
      key: registry-config.toml
{{- end -}}
{{- end -}}

{{/*
Generate the content of /etc/containerd/conf.d/registry-config.toml in nodes
for registry configuration
*/}}
{{- define "registrySecretContent" -}}
version = 2

[plugins."io.containerd.grpc.v1.cri".registry]

[plugins."io.containerd.grpc.v1.cri".registry.mirrors]
{{- range $registry, $mirrors := .Values.connectivity.containerRegistries}}

[plugins."io.containerd.grpc.v1.cri".registry.mirrors."{{$registry}}"]
{{- $endpoints := list -}}
{{- range $mirrors }}{{- $endpoints = append $endpoints .endpoint }}{{- end }}
endpoint = [ "{{join "\" , \"" $endpoints}}" ]

{{- end }}

[plugins."io.containerd.grpc.v1.cri".registry.configs]

{{- range $registry, $mirrors := .Values.connectivity.containerRegistries}}
{{- range $mirrors }}

{{- if .credentials }}
[plugins."io.containerd.grpc.v1.cri".registry.configs."{{.endpoint}}".auth]
{{- range $key, $value := .credentials }}
{{ $key}}={{$value |quote}}
{{- end }}
{{ end }}

{{- end }}
{{- end }}

{{- end -}}

{{/*
Generate name of the k8s secret that contains containerd configuration for registries.
When there is a change in the secret, it is not recognized by CAPI controllers.
To enforce upgrades, a version suffix is appended to secret name.
*/}}
{{- define "registrySecretName" -}}
{{- $secretSuffix := include "registrySecretContent" . | b64enc | quote | sha1sum | trunc 8 }}
{{- include "resource.default.name" $ }}-registry-configuration-{{$secretSuffix}}
{{- end -}}
