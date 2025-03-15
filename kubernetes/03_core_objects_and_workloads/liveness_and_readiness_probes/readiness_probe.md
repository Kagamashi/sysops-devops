
## **Readiness Probes**
A **Readiness Probe** determines whether a container is **ready to accept traffic**. If the probe fails, Kubernetes **removes the Pod from service discovery** (i.e., it stops sending traffic to it but does not restart it).

### **When to Use Readiness Probes?**
- When a container needs time to **initialize** (e.g., waiting for DB connections).
- If an application needs to **load configurations** before becoming available.
- To handle **temporary unavailability** (e.g., high load causing slow response).

### **Readiness Probe Configuration:**
Readiness probes use the same mechanisms as liveness probes (HTTP, TCP, Exec).

#### **Example: Readiness Probe with HTTP Check**
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: readiness-example
spec:
  containers:
  - name: my-app
    image: my-app:latest
    readinessProbe:
      httpGet:
        path: /ready
        port: 8080
      initialDelaySeconds: 5  # Delay before starting checks
      periodSeconds: 10
      successThreshold: 2  # Requires 2 consecutive successes
```

#### **Example: Readiness Probe with TCP Check**
```yaml
readinessProbe:
  tcpSocket:
    port: 8080
  initialDelaySeconds: 5
  periodSeconds: 10
```

---
