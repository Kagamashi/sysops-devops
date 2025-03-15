## Sync Policies

### **Self Heal**
- Automatically corrects any drift between the desired state (Git) and the live state (Kubernetes cluster).
- Reapplies the desired state when changes are detected.

### **Pruning**
- Automatically removes resources that are present in the Kubernetes cluster but no longer exist in the Git repository.

#### Example Sync Policy Configuration:
```yaml
syncPolicy:
  automated:
    prune: true           # Automatically remove resources no longer defined in Git
    selfHeal: true         # Automatically correct drift between the cluster and Git
  syncOptions:
    - CreateNamespace=true  # Automatically create namespace if it doesn’t exist
    - PrunePropagationPolicy=foreground  # Controls how resources are deleted
    - SyncTimeout=300  # Timeout in seconds (300 seconds = 5 minutes)
```

---

## Sync Phases

ArgoCD provides three distinct phases during the sync process:

### **PreSync**
- Custom logic or tasks defined to run before the sync process starts.

### **Sync**
- ArgoCD applies Kubernetes resources from the Git repository to the cluster.

### **PostSync**
- Custom logic or tasks defined to run after the sync process is completed.

#### Example PreSync Hook:
```yaml
apiVersion: batch/v1
kind: Job
metadata:
  name: pre-sync-job
  annotations:
    argocd.argoproj.io/hook: PreSync  # Run this job before the sync starts
spec:
  template:
    spec:
      containers:
        - name: my-job
          image: my-job-image
      restartPolicy: OnFailure
```

---

## Sync Options

- **Allow Empty**: Allows syncing applications even if no resources are defined in the Git repository.
- **Prune Resources**: Deletes resources that exist in the cluster but no longer exist in the Git repository.
- **Force Sync**: Forces the application to synchronize, even if it's already in sync.

---

## Sync Waves

Sync waves allow you to control the order in which resources are applied. Resources in lower waves are applied before those in higher waves. This is particularly useful for managing dependencies (e.g., applying services before deployments).

#### Example Sync Wave Annotation:
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-app
  annotations:
    argocd.argoproj.io/sync-wave: "1"  # Apply this resource in sync wave 1
spec:
  replicas: 3
  template:
    spec:
      containers:
        - name: my-app-container
          image: my-app:latest
```
