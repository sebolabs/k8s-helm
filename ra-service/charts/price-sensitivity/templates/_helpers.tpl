{{/*
Default labels
*/}}
{{- define "priceSensitivity.labels" -}}
helm.sh/chart: {{ include "ra.chart" . }}
{{ include "priceSensitivity.selectorLabels" . }}
app.kubernetes.io/version: {{ .Values.global.services.priceSensitivity.version | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "priceSensitivity.selectorLabels" -}}
app.kubernetes.io/name: {{ .Chart.Name }}
app.kubernetes.io/release: {{ .Release.Name }}
{{- end -}}
