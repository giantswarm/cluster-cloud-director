{{/*
Converts disk size from gigabytes to bytes.
*/}}
{{- define "calculateDiskBytes" -}}
{{- mul $ 1024 1024 1024 }}
{{- end -}}

{{/*
Hash function based on data provided
Expects two arguments (as a `dict`) E.g.
  {{ include "hash" (dict "data" . "salt" .Values.providerIntegration.hasSalt) }}
Where `data` is the data to hash and `global` is the top level scope.

NOTE: this function has been copied from the giantswarm/cluster chart
(see `cluster.data.hash``) to ensure that resource naming is identical.
*/}}
{{- define "machineTemplateSpec.hash" -}}
{{- $data := mustToJson .data | toString  }}
{{- $salt := "" }}
{{- if .salt }}{{ $salt = .salt}}{{end}}
{{- (printf "%s%s" $data $salt) | quote | sha1sum | trunc 8 }}
{{- end -}}
