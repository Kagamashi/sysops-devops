# App Engine

## 1. Overview
Google App Engine is a fully managed **Platform as a Service (PaaS)** that enables developers to deploy applications without managing infrastructure. It supports two environments: **Standard** and **Flexible**.

---

## 2. Standard vs Flexible Environment

### **1. Standard Environment**
- Supports predefined **runtimes** (Python, Java, Node.js, Go, PHP, Ruby).
- **Auto-scales instantly** based on traffic.
- **Fast deployment** with minimal configuration.
- Runs on **sandboxed environments** with Google-managed instances.
- **Cold start latency** when scaling to zero.

```yaml
runtime: python39  # Example for Standard Environment
instance_class: F2  # Defines CPU/memory allocation
```

### **2. Flexible Environment**
- Supports **custom runtimes** (any language with a Docker container).
- Runs on **Compute Engine VMs** with full OS access.
- **Longer startup times**, but persistent instances.
- More control over **networking, storage, and system dependencies**.
- Ideal for applications requiring **custom libraries, background processing, and extended request handling**.

```yaml
runtime: custom  # Example for Flexible Environment
env: flex
resources:
  cpu: 2
  memory_gb: 4
  disk_size_gb: 10
```

📌 **Choosing the Right Environment:**
- Use **Standard** for quick scaling, cost-efficiency, and stateless apps.
- Use **Flexible** for custom runtimes, background processes, and high-performance workloads.

---

## 3. App Engine Services, Versions, and Traffic Splitting

### **1. App Engine Services**
- Applications can be **split into multiple services**, each running independently.
- Allows modular architectures where services can be scaled and updated separately.
- Each service can have **its own scaling policy, environment, and versioning**.

```yaml
service: backend-service  # Defines a service in app.yaml
```

### **2. App Engine Versions**
- Each deployment creates a new **version** of the application.
- Versions allow **rollback, canary testing, and controlled updates**.
- Old versions remain available unless manually deleted.

```sh
gcloud app deploy --version=v2  # Deploying a new version
```

### **3. Traffic Splitting**
- Allows **gradual rollouts** between multiple versions.
- Supports **IP-based and random assignment** for A/B testing.
- Can distribute traffic across multiple deployed versions.

```sh
gcloud app services set-traffic default \
  --splits v1=0.7,v2=0.3  # 70% to v1, 30% to v2
```

---

## 4. Final Checklist
✅ Use **Standard Environment** for fast, cost-effective scaling.
✅ Choose **Flexible Environment** for custom runtimes and background jobs.
✅ Structure applications using **multiple services** for modular deployment.
✅ Manage versions carefully and leverage **traffic splitting** for gradual rollouts.
✅ Use **App Engine's autoscaling features** to optimize costs.

📌 **More Resources:** [Google App Engine Documentation](https://cloud.google.com/appengine/docs/)

