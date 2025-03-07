
## Template Syntax and Functions

Helm templates use **Go templating** to generate Kubernetes manifests dynamically.

### **Basic Template Example**
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ .Release.Name }}-app
  labels:
    app: {{ .Chart.Name }}
spec:
  replicas: {{ .Values.replicaCount }}
```
- **`{{ .Release.Name }}`** → Inserts the release name.
- **`{{ .Chart.Name }}`** → Inserts the chart name.
- **`{{ .Values.replicaCount }}`** → Reads a value from `values.yaml`.

### **Using the Sprig Library for Functions**
- String manipulation: `{{ upper "hello" }}` → **HELLO**
- Default values: `{{ .Values.env | default "production" }}`
- Lists and conditionals:
```yaml
{{- if .Values.enableFeature }}
  enabled: true
{{- end }}
```

### **Template Helpers (`_helpers.tpl`)**
Reusable functions are defined in `_helpers.tpl`:
```yaml
{{- define "app.fullname" -}}
{{ .Release.Name }}-{{ .Chart.Name }}
{{- end }}
```
Usage inside templates:
```yaml
metadata:
  name: {{ include "app.fullname" . }}
```

---

## Common Resources and Patterns

Helm templates commonly generate Kubernetes **Deployments, Services, Ingress, ConfigMaps, and Secrets**.

### **Deployment Template Example**
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ include "app.fullname" . }}
spec:
  replicas: {{ .Values.replicaCount }}
  template:
    spec:
      containers:
        - name: app
          image: {{ .Values.image.repository }}:{{ .Values.image.tag }}
```

### **Service Template Example**
```yaml
apiVersion: v1
kind: Service
metadata:
  name: {{ include "app.fullname" . }}
spec:
  selector:
    app: {{ .Chart.Name }}
  ports:
    - port: 80
      targetPort: 8080
```

### **Ingress Template Example**
```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: {{ include "app.fullname" . }}
spec:
  rules:
    - host: {{ .Values.ingress.host }}
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: {{ include "app.fullname" . }}
                port:
                  number: 80
```
