
## Diffing and Preview

### **How ArgoCD Diffs Live Resources vs Desired State**
- ArgoCD continuously compares the **live state** of Kubernetes resources with the **desired state** defined in Git.
- Differences between the two states trigger **OutOfSync** status, prompting users to review and sync changes.
- Supports detailed side-by-side diff views in the UI and CLI.

### **Overriding Diff Settings**
- Certain fields may change dynamically (e.g., timestamps, annotations). To prevent unnecessary syncs, ArgoCD allows overriding diff settings.

#### Example Override:
```yaml
ignoreDifferences:
  - group: apps
    kind: Deployment
    jsonPointers:
      - /spec/replicas
      - /metadata/annotations
```

### **Ignoring Metadata**
- Metadata such as **timestamps, labels, and auto-generated fields** can be ignored to prevent unnecessary drift detection.
- Helps avoid continuous reconciliation due to non-functional changes.

ArgoCD’s flexible diffing mechanisms ensure that only meaningful changes trigger updates, reducing operational noise and unnecessary redeployments.

