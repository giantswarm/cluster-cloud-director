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
infrastructure.cluster.x-k8s.io/v1beta2
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
{{- if .Values.global.metadata.organization }}
giantswarm.io/organization: {{ .Values.global.metadata.organization | quote }}
{{- end }}
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
Create label to prevent accidental cluster deletion
*/}}
{{- define "preventDeletionLabel" -}}
{{- if $.Values.global.metadata.preventDeletion -}}
giantswarm.io/prevent-deletion: "true"
{{ end -}}
{{- end -}}

{{/*
Create a prefix for all resource names.
*/}}
{{- define "resource.default.name" -}}
{{- .Values.global.metadata.name | default (.Release.Name | replace "." "-" | trunc 47 | trimSuffix "-") -}}
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
{{ .Values.global.connectivity.proxy.secretName | default $defaultContainerdProxySecret }}
{{- end -}}

{{- define "containerdProxyConfig" -}}
- path: /etc/systemd/system/containerd.service.d/99-http-proxy.conf
  permissions: "0600"
  contentFrom:
    secret:
      name: {{ include "containerdProxySecret" $ }}
      key: containerdProxy   
{{- end -}}

{{- define "teleportProxyConfig" -}}
- path: /etc/systemd/system/teleport.service.d/99-http-proxy.conf
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
    {{- range $.Values.global.connectivity.network.staticRoutes}}
    ExecStart=/bin/bash -c "ip route add {{ .destination }} via {{ .via }}"
    {{- end -}}
{{- end }}

{{/*
The secret `-teleport-join-token` is created by the teleport-operator in cluster namespace
and is used to join the node to the teleport cluster.
*/}}
{{- define "teleportFiles" -}}
- path: /etc/teleport-join-token
  permissions: "0644"
  contentFrom:
    secret:
      name: {{ include "resource.default.name" $ }}-teleport-join-token
      key: joinToken
- path: /etc/teleport.yaml
  permissions: "0644"
  encoding: base64
  content: {{ tpl ($.Files.Get "files/etc/teleport.yaml") . | b64enc }}
- path: /opt/teleport-node-role.sh
  permissions: "0755"
  encoding: base64
  content: {{ $.Files.Get "files/opt/teleport-node-role.sh" | b64enc }}
- path: /etc/systemd/system/teleport.service
  permissions: "0644"
  encoding: base64
  content: {{ tpl ($.Files.Get "files/systemd/teleport.service") . | b64enc }}
{{- end -}}

{{- define "hostEntries" -}}
{{- range $.Values.global.connectivity.network.hostEntries}}
- echo "{{ .ip }}  {{ .fqdn }}" >> /etc/hosts
{{- end -}}
{{- end }}

{{/*
Updates in KubeadmConfigTemplate will not trigger any rollout for worker nodes.
It is necessary to create a new template with a new name to trigger an upgrade.
See https://github.com/kubernetes-sigs/cluster-api/issues/4910
See https://github.com/kubernetes-sigs/cluster-api/pull/5027/files
*/}}
{{- define "kubeadmConfigTemplateSpec" -}}

{{ include "sshUsers" . }}

joinConfiguration:
  nodeRegistration:
    criSocket: /run/containerd/containerd.sock
    kubeletExtraArgs:
      {{- include "kubeletExtraArgs" . | nindent  6 -}}
      node-labels: "giantswarm.io/node-pool={{ .pool.name }},{{- include "labelsByClass" .pool -}}"
    {{- include "taintsByClass" .pool | nindent  4}}

{{- if eq $.Values.global.providerSpecific.vmBootstrapFormat "ignition" }}
{{ include "ignitionSpec" . }}
{{- end }}

files:
{{- if eq $.Values.global.providerSpecific.vmBootstrapFormat "cloud-config" }}
{{- include "ntpFiles" . | nindent 2}}
{{- end }}
{{- include "sshFiles" . | nindent 2}}
{{- include "containerdConfig" . | nindent 2 }}
{{- if $.Values.global.connectivity.proxy.enabled }}
{{- include "containerdProxyConfig" . | nindent 2}}
{{- end }}
{{- if and $.Values.internal.teleport.enabled $.Values.global.connectivity.proxy.enabled }}
{{- include "teleportProxyConfig" . | nindent 2}}
{{- end }}
{{- if $.Values.internal.teleport.enabled }}
{{- include "teleportFiles" . | nindent 2}}
{{- end }}
{{- if $.Values.global.connectivity.network.staticRoutes }}
{{- if eq $.Values.global.providerSpecific.vmBootstrapFormat "cloud-config" }}
{{- include "staticRoutes" . | nindent 2}}
{{- end }}
{{- end }}

preKubeadmCommands:
- /bin/test ! -d /var/lib/kubelet && (/bin/mkdir -p /var/lib/kubelet && /bin/chmod 0750 /var/lib/kubelet)
{{- if $.Values.global.connectivity.proxy.enabled }}
- systemctl daemon-reload
- systemctl restart containerd
{{- end }}
{{- include "hostEntries" .}}
{{- if $.Values.global.connectivity.network.staticRoutes }}
{{- if eq $.Values.global.providerSpecific.vmBootstrapFormat "cloud-config" }}
- systemctl daemon-reload
- systemctl enable --now static-routes.service
{{- end }}
{{- end }}
{{- if $.Values.internal.teleport.enabled }}
- systemctl daemon-reload
- systemctl enable --now teleport.service
{{- end }}
postKubeadmCommands:
{{ include "sshPostKubeadmCommands" . }}
{{- if eq $.Values.global.providerSpecific.vmBootstrapFormat "cloud-config" }}
{{- include "ntpPostKubeadmCommands" . }}
{{- end }}
- usermod -aG root nobody # required for node-exporter to access the host's filesystem

{{- end }}

{{- define "kubeadmConfigTemplateRevision" -}}
{{- $inputs := (dict
  "data" (replace "\n\n" "\n" (include "kubeadmConfigTemplateSpec" .)) ) }}
{{- mustToJson $inputs | toString | quote | sha1sum | trunc 8 }}
{{- end -}}

{{/*
VCDMachineTemplate is immutable. We need to create new versions during upgrades.
Here we are generating a hash suffix to trigger upgrade when only it is necessary by
using only the parameters used in vcdmachinetemplate.yaml.
diskSize is computed with 1024^3 instead of 1000^3 because of https://github.com/vmware/cluster-api-provider-cloud-director/blob/501b616011dced31ddf3e0e3da0036a7a49ce015/controllers/vcdmachine_controller.go#L651
*/}}

{{- define "mtSpec" -}}
catalog: {{ .currentPool.catalog }}
template: {{ .currentPool.template }}
sizingPolicy: {{ .currentPool.sizingPolicy }}
placementPolicy: {{ .currentPool.placementPolicy }}
storageProfile: {{ .currentPool.storageProfile }}
diskSize: {{ mul .currentPool.diskSizeGB 1024 1024 1024 }}
vmNamingTemplate: {{ $.global.providerSpecific.vmNamingTemplate }}
{{- if $.global.connectivity.network.extraOvdcNetworks }}
extraOvdcNetworks:
  {{- range $.global.connectivity.network.extraOvdcNetworks }}
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

{{/*
mtRevision takes a dict which includes the node's spec and computes a hash value
from it. This hash value is appended to the name of immutable resources to facilitate
node replacement when the node spec is changed.
*/}}
{{- define "mtRevision" -}}
{{- $inputs := (dict
  "spec" (include "mtSpec" .)
  "infrastructureApiVersion" ( include "infrastructureApiVersion" . ) ) }}
{{- mustToJson $inputs | toString | quote | sha1sum | trunc 8 }}
{{- end -}}

{{/*
First takes a map of the controlPlane's spec and adds it to a new map, then
takes a array of maps containing nodePools and adds each nodePool's map to
the new map. Reults in a map of node specs which can be iterated over to 
create VCDMachineTemplates.
*/}}
{{ define "createMapOfClusterNodeSpecs" }}
{{- $nodeMap := dict -}}
{{- $_ := set $nodeMap "control-plane" .Values.global.controlPlane -}}
{{ toYaml $nodeMap }}
{{- end }}
{{/*
Takes an array of maps containing worker nodePools and adds each map to a new
map. Results in a map of node specs which can be iterated over to create
MachineDeployments.
*/}}
{{ define "createMapOfWorkerPoolSpecs" -}}
{{- $nodeMap := dict -}}
{{- range $index, $pool := .Values.global.nodePools | default .Values.cluster.providerIntegration.workers.defaultNodePools -}}
  {{- $_ := set $nodeMap $index $pool -}}
{{- end -}}
{{ toYaml $nodeMap }}
{{- end }}

{{- define "taintsByClass" -}}
{{- $outerScope := . }}
{{- include "taints" $outerScope.customNodeTaints }}
{{- end -}}

{{- define "labelsByClass" -}}
{{- $outerScope := . }}
{{- join "," $outerScope.customNodeLabels -}}
{{- end -}}

{{- define "mtRevisionByControlPlane" -}}
{{- $outerScope := . }}
{{- include "mtRevision" (merge (dict "currentPool" .Values.global.controlPlane) $outerScope.Values) }}
{{- end -}}

{{/*
Generate a stanza for KubeAdmConfig and KubeAdmControlPlane in order to 
mount containerd configuration.
*/}}
{{- define "containerdConfig" -}}
- path: /etc/containerd/config.toml
  permissions: "0600"
  contentFrom:
    secret:
      name: {{ include "containerdConfigSecretName" $ }}
      key: registry-config.toml
{{- end -}}

{{/*
Generate name of the k8s secret that contains containerd configuration for registries.
When there is a change in the secret, it is not recognized by CAPI controllers.
To enforce upgrades, a version suffix is appended to secret name.
*/}}
{{- define "containerdConfigSecretName" -}}
{{- $secretSuffix := tpl ($.Files.Get "files/etc/containerd/config.toml") $ | b64enc | quote | sha1sum | trunc 8 }}
{{- include "resource.default.name" $ }}-registry-configuration-{{$secretSuffix}}
{{- end -}}

{{- define "auditLogFiles" -}}
- path: /etc/kubernetes/policies/audit-policy.yaml
  permissions: "0600"
  encoding: base64
  content: {{ $.Files.Get "files/etc/kubernetes/policies/audit-policy.yaml" | b64enc }}
{{- end -}}
