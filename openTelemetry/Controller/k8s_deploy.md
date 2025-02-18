
## **Deploying OpenTelemetry Collector**
The OpenTelemetry Collector can be deployed using **Docker, Kubernetes, or manually on a VM**.

### **Option 1: Running with Docker**
```sh
docker run --rm -p 4317:4317 -p 4318:4318 \
  -v $(pwd)/otel-config.yaml:/etc/otel/config.yaml \
  otel/opentelemetry-collector --config=/etc/otel/config.yaml
```

### **Option 2: Deploying in Kubernetes (Manifest Example)**
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: otel-collector
spec:
  replicas: 2
  selector:
    matchLabels:
      app: otel-collector
  template:
    metadata:
      labels:
        app: otel-collector
    spec:
      containers:
      - name: otel-collector
        image: otel/opentelemetry-collector:latest
        args:
        - "--config=/etc/otel/config.yaml"
        volumeMounts:
        - name: config-volume
          mountPath: /etc/otel
      volumes:
      - name: config-volume
        configMap:
          name: otel-config
```

### **Option 3: Deploying with Helm (Recommended for Kubernetes)**
```sh
helm repo add open-telemetry https://open-telemetry.github.io/opentelemetry-helm-charts
helm install my-otel open-telemetry/opentelemetry-collector --values my-values.yaml
```

---
