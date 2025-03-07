# Helm Values and Configuration

## Values File Basics

Helm allows customization of charts using **values.yaml**, which provides default values that can be overridden.

### **Example `values.yaml`**
```yaml
replicaCount: 2
image:
  repository: nginx
  tag: latest
  pullPolicy: IfNotPresent
ingress:
  enabled: true
  host: example.com
env:
  logLevel: debug
```

### **Overriding Values at Install Time**
#### Using `--set` (Inline Overrides)
```bash
helm install myapp ./mychart --set replicaCount=3,image.tag=1.2.3
```

#### Using `-f` (Custom Values File)
```bash
helm install myapp ./mychart -f custom-values.yaml
```

### **Hierarchical Data in `values.yaml`**
- Nested values are accessed using dot notation in templates.
- Example:
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ .Release.Name }}-app
spec:
  template:
    spec:
      containers:
        - name: app
          image: {{ .Values.image.repository }}:{{ .Values.image.tag }}
```

---

## Multiple Environment Overlays

### **Using Separate `values` Files for Environments**
Define separate files for different environments:
```bash
helm install myapp ./mychart -f values-prod.yaml
```

### **Example: `values-dev.yaml`**
```yaml
replicaCount: 1
ingress:
  host: dev.example.com
env:
  logLevel: debug
```

### **Example: `values-prod.yaml`**
```yaml
replicaCount: 5
ingress:
  host: prod.example.com
env:
  logLevel: info
```

### **Handling Secrets and Sensitive Data**
- Use **Helm Secrets Plugin** (e.g., SOPS, GPG encryption)
- Store secrets in Kubernetes **Secrets** instead of `values.yaml`

---

## Best Practices for Parameterization

### **Minimizing Duplication with Default Values**
- Provide reasonable defaults in `values.yaml`
- Use `default` function for optional values:
```yaml
logLevel: {{ .Values.env.logLevel | default "info" }}
```

### **Organizing Complex Variables**
- Structure related values under the same key:
```yaml
service:
  type: ClusterIP
  port: 80
```
```yaml
spec:
  ports:
    - port: {{ .Values.service.port }}
```
