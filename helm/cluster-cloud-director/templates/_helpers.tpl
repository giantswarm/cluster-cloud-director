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
{{- if $.Values.ssh.users }}
{{- range $.Values.ssh.users -}}
users:
- name: {{ .name }}
  sshAuthorizedKeys:
  {{- range .authorizedKeys }}
  - {{ . }}
  {{- end }}
{{- end -}}
{{- end }}
joinConfiguration:
  nodeRegistration:
    criSocket: /run/containerd/containerd.sock
    kubeletExtraArgs:
      {{- include "kubeletExtraArgs" . | nindent  6}}
      node-labels: "giantswarm.io/node-pool={{ .pool.name }}"
files:
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
postKubeadmCommands:
{{- if $.Values.network.staticRoutes }}
- systemctl daemon-reload
- systemctl enable static-routes.service
{{- end }}
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
*/}}
{{- define "mtSpec" -}}
catalog: {{ .currentClass.catalog }}
template: {{ .currentClass.template }}
sizingPolicy: {{ .currentClass.sizingPolicy }}
placementPolicy: {{ .currentClass.placementPolicy }}
storageProfile: {{ .currentClass.storageProfile }}
{{- if $.network.extraOvdcNetworks }}
extraOvdcNetworks:
  {{- range $.network.extraOvdcNetworks }}
  - {{ . }}
  {{- end }}
{{- end -}}
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

{{- define "mtRevisionByControlPlane" -}}
{{- $outerScope := . }}
{{- include "mtRevision" (merge (dict "currentClass" .Values.controlPlane) $outerScope.Values) }}
{{- end -}}
