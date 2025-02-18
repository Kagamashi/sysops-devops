# Common Helm Resources and Patterns

## **1. Introduction**
Helm charts typically deploy a variety of Kubernetes resources to manage applications effectively. Understanding common resource types and best practices ensures **reliable, scalable, and maintainable** deployments.

### **Key Kubernetes Resources Managed via Helm**
- **Deployments** → For managing stateless applications.
- **StatefulSets** → For stateful applications requiring persistent storage.
- **Services** → For exposing workloads internally or externally.
- **Ingress** → For routing external traffic to internal services.
- **ConfigMaps & Secrets** → For storing configuration data securely.
- **Persistent Volume Claims (PVCs)** → For managing storage needs.
- **Jobs & CronJobs** → For batch processing tasks.

---

## **2. Helm Template Examples for Common Resources**
### **Deployments**
Deployments ensure that a **desired number of replicas** of an application are running.

#### **Example: `templates/deployment.yaml`**
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ .Release.Name }}-app
  labels:
    app: {{ .Release.Name }}
spec:
  replicas: {{ .Values.replicaCount }}
  selector:
    matchLabels:
      app: {{ .Release.Name }}
  template:
    metadata:
      labels:
        app: {{ .Release.Name }}
    spec:
      containers:
        - name: app-container
          image: "{{ .Values.image.repository }}:{{ .Values.image.tag }}"
          ports:
            - containerPort: {{ .Values.service.port }}
```

#### **Example: `values.yaml` for Deployment**
```yaml
replicaCount: 3
image:
  repository: nginx
  tag: latest
service:
  port: 80
```

---

### **Services**
Services expose workloads internally or externally within the cluster.

#### **Example: `templates/service.yaml`**
```yaml
apiVersion: v1
kind: Service
metadata:
  name: {{ .Release.Name }}-service
spec:
  type: {{ .Values.service.type }}
  selector:
    app: {{ .Release.Name }}
  ports:
    - protocol: TCP
      port: {{ .Values.service.port }}
      targetPort: {{ .Values.service.port }}
```

#### **Example: `values.yaml` for Service**
```yaml
service:
  type: ClusterIP
  port: 80
```

---

### **Ingress**
Ingress resources manage HTTP/S traffic routing to internal services.

#### **Example: `templates/ingress.yaml`**
```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: {{ .Release.Name }}-ingress
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  rules:
    - host: {{ .Values.ingress.host }}
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: {{ .Release.Name }}-service
                port:
                  number: {{ .Values.service.port }}
```

#### **Example: `values.yaml` for Ingress**
```yaml
ingress:
  enabled: true
  host: example.com
```

---

### **ConfigMaps & Secrets**
ConfigMaps and Secrets provide configuration data to applications.

#### **Example: `templates/configmap.yaml`**
```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .Release.Name }}-config
  labels:
    app: {{ .Release.Name }}
data:
  APP_ENV: "{{ .Values.config.env }}"
  LOG_LEVEL: "{{ .Values.config.logLevel }}"
```

#### **Example: `values.yaml` for ConfigMap**
```yaml
config:
  env: production
  logLevel: info
```

#### **Example: `templates/secret.yaml`**
```yaml
apiVersion: v1
kind: Secret
metadata:
  name: {{ .Release.Name }}-secret
type: Opaque
data:
  DB_PASSWORD: {{ .Values.secrets.dbPassword | b64enc }}
```

#### **Example: `values.yaml` for Secret**
```yaml
secrets:
  dbPassword: mySecurePassword
```

> **Best Practice:** Avoid storing secrets in plaintext inside `values.yaml`. Use **external secret management** tools like **Sealed Secrets, Vault, or External Secrets Operator**.

---

### **Persistent Volume Claims (PVCs)**
PVCs ensure applications get dedicated storage.

#### **Example: `templates/pvc.yaml`**
```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: {{ .Release.Name }}-pvc
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: {{ .Values.persistence.size }}
```

#### **Example: `values.yaml` for PVC**
```yaml
persistence:
  size: 1Gi
```

---

### **Jobs & CronJobs**
Jobs and CronJobs handle batch processes or scheduled tasks.

#### **Example: `templates/job.yaml`**
```yaml
apiVersion: batch/v1
kind: Job
metadata:
  name: {{ .Release.Name }}-job
spec:
  template:
    spec:
      containers:
        - name: job-container
          image: "{{ .Values.job.image.repository }}:{{ .Values.job.image.tag }}"
          command: ["echo", "Running job task"]
      restartPolicy: Never
```

#### **Example: `values.yaml` for Job**
```yaml
job:
  image:
    repository: busybox
    tag: latest
```

---
