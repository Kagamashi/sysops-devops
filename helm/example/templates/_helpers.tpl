# _helpers.tpl contains template helper functions to avoid repetition

# uses fullnameOverride if provided, default to {release-name}-{chart-name}
{{- define "common.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{ .Values.fullnameOverride }}
{{- else -}}
{{ .Release.Name }}-{{ .Chart.Name }}
{{- end -}}
{{- end -}}
# metadata:
#   name: {{ include "common.fullname" . }}


# ensures all resources share consistent metadata
# adds Helm specific labels for tracking version and release
{{- define "common.labels" -}}
app.kubernetes.io/name: {{ .Chart.Name }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion }}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version }}
{{- end -}}
# metadata:
#   labels:
#     {{- include "common.labels" . | nindent 4 }}


# maintains consistent selector for Deployments, StatefulSets, Services
{{- define "common.selectorLabels" -}}
app.kubernetes.io/name: {{ .Chart.Name }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}
# spec:
#   selector:
#     matchLabels:
#       {{- include "common.selectorLabels" . | nindent 6 }}


# image reference - uses value from values.yaml or default to appVersion if tag is not set
{{- define "common.image" -}}
{{ .Values.image.repository }}:{{ .Values.image.tag | default .Chart.AppVersion }}
{{- end -}}
# containers:
#   - name: app
#     image: {{ include "common.image" . }}


# boolean flag function
{{- define "common.bool" -}}
{{- if .Values.someFeatureEnabled -}}true{{- else -}}false{{- end -}}
{{- end -}}
# env:
#   - name: FEATURE_ENABLED
#     value: "{{ include "common.bool" . }}"


# secret lookup
# use existing secret if specified in values.yaml, otherwise generates a default name
{{- define "common.existingSecret" -}}
{{- if .Values.existingSecret -}}
  {{ .Values.existingSecret }}
{{- else -}}
  {{ include "common.fullname" . }}-secret
{{- end -}}
{{- end -}}
# metadata:
#   name: {{ include "common.existingSecret" . }}


# resource limits function
# ensures structured way to define CPU and memory limits
# (provides sane defaults while allowing custom resource settings from values.yaml)
{{- define "common.resources" -}}
{{- if .Values.resources -}}
resources:
  {{- toYaml .Values.resources | nindent 2 }}
{{- else -}}
resources:
  requests:
    cpu: "100m"
    memory: "128Mi"
  limits:
    cpu: "500m"
    memory: "256Mi"
{{- end -}}
{{- end -}}
# containers:
#   - name: app
#     {{ include "common.resources" . | nindent 6 }}
