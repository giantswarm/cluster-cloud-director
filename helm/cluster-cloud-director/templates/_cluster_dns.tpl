{{/* vim: set filetype=mustache: */}}

{{/*
    clusterDNS IP is defined as 10th IP of the service CIDR in kubeadm. See:

    https://github.com/kubernetes/kubernetes/blob/d89d5ab2680bc74fe4487ad71e514f4e0812d9ce/cmd/kubeadm/app/constants/constants.go#L644-L645

    Such advanced logic can't be used in helm chart. Instead there is an
    assertion that the network is bigger than /24 and the last octet simply
    replaced with .10.
*/}}
{{- define "clusterDNS" -}}
    {{- $serviceCidrBlock := index .Values.connectivity.network.services.cidrBlocks 0 -}}
    {{- $mask := int (mustRegexReplaceAll `^.*/(\d+)$` $serviceCidrBlock "${1}") -}}

    {{- if gt $mask 24 -}}
        {{- fail (printf ".Values.connectivity.network.services.cidrBlocks[0]=%q mask must be <= 24" $serviceCidrBlock) -}}
    {{- end -}}

    {{- mustRegexReplaceAll `^(\d+\.\d+\.\d+).*$` $serviceCidrBlock "${1}.10" -}}
{{- end -}}
