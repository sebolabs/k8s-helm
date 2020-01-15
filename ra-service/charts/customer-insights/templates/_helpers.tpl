{{/*
Default labels
*/}}
{{- define "customerInsights.labels" -}}
helm.sh/chart: {{ include "ra.chart" . }}
{{ include "customerInsights.selectorLabels" . }}
app.kubernetes.io/version: {{ .Values.global.services.customerInsights.version | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "customerInsights.selectorLabels" -}}
app.kubernetes.io/name: {{ .Chart.Name }}
app.kubernetes.io/release: {{ .Release.Name }}
{{- end -}}
