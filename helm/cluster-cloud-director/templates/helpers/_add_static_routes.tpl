{{/*
This template generates a script to add static routes to nodes (if defined in the
values file).

The script is templated into the secret created by the `provider-specific-files.yaml`
template in the `templates` directory so that it can be referenced in the chart's
values file.
*/}}
{{- define "addStaticRoutes" -}}
#!/bin/sh
{{- if $.Values.global.connectivity.network.staticRoutes -}}
set -x
{{- range $.Values.global.connectivity.network.staticRoutes }}
/usr/bin/bash -cv 'ip route add {{ .destination }} via {{ .via }}'
{{- end }}
{{- else -}}
echo "No static routes to add, exiting"
exit 0
{{ end }}
{{- end }}