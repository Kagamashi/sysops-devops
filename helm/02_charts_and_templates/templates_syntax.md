
## **Helm Template Syntax and Functions**
Helm uses **Go templates** to dynamically generate Kubernetes manifests. It supports **Sprig functions**, template helpers, and logical operators.

### **Basic Template Syntax**
```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .Values.configMapName }}
data:
  key: {{ .Values.someValue }}
```
- `{{ .Values.configMapName }}` retrieves a value from `values.yaml`.

### **Control Structures: If-Else Statements**
```yaml
{{- if .Values.enableFeature }}
kind: ConfigMap
metadata:
  name: feature-config
{{- else }}
# Feature disabled
{{- end }}
```
- Conditionally creates resources **only if** `enableFeature` is `true`.

### **Loops (Range Over Lists)**
```yaml
{{- range .Values.replicaList }}
apiVersion: v1
kind: Pod
metadata:
  name: {{ . }}
{{- end }}
```
- Loops over `replicaList` and creates multiple pods.

### **Using `_helpers.tpl` for Reusability**
Define a helper function in `_helpers.tpl`:
```yaml
{{- define "app.name" }}
{{ .Release.Name }}-myapp
{{- end }}
```
Use it in templates:
```yaml
metadata:
  name: {{ include "app.name" . }}
```
- This prevents repetition across templates.

### **Using Sprig Functions**
```yaml
metadata:
  name: {{ .Values.appName | lower | replace " " "-" }}
```
- Converts `appName` to lowercase and replaces spaces with hyphens.

### **Merging Default and User-Provided Values**
```yaml
{{ .Values | merge (dict "replicaCount" 2) }}
```
- Merges values with defaults.

---
