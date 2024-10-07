{{/*
Converts disk size from gigabytes to bytes.
*/}}
{{- define "calculateDiskBytes" -}}
{{- mul $ 1024 1024 1024 }}
{{- end -}}