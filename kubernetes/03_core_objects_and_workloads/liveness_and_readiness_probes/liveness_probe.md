
## **Liveness Probes**
A **Liveness Probe** determines whether a container is still **running properly**. If the probe fails, Kubernetes **restarts** the container.

### **When to Use Liveness Probes?**
- If an application **enters a deadlock** (e.g., an infinite loop).
- If a container stops responding but does not terminate.
- When **self-recovery mechanisms** are insufficient.

### **Liveness Probe Configuration:**
Kubernetes supports three types of liveness probes:
1. **HTTP Probe** (Checks an HTTP endpoint)
2. **TCP Probe** (Checks if a port is open)
3. **Exec Probe** (Runs a command inside the container)

#### **Example: HTTP Liveness Probe**
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: liveness-example
spec:
  containers:
  - name: my-app
    image: my-app:latest
    livenessProbe:
      httpGet:
        path: /healthz  # Health check endpoint
        port: 8080
      initialDelaySeconds: 3  # Delay before starting the first check
      periodSeconds: 10  # How often to check
      failureThreshold: 3  # Restart after 3 failures
```

#### **Example: TCP Liveness Probe**
```yaml
livenessProbe:
  tcpSocket:
    port: 3306  # Checks if the database port is reachable
  initialDelaySeconds: 5
  periodSeconds: 10
```

#### **Example: Exec Liveness Probe**
```yaml
livenessProbe:
  exec:
    command: ["cat", "/tmp/healthy"]  # Checks if a file exists
  initialDelaySeconds: 5
  periodSeconds: 10
```

---
