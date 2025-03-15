
## Restricting AppProject Scopes

**AppProjects** allow restricting deployments to specific namespaces, clusters, and repositories, ensuring security and isolation.

### Example AppProject with Restricted Scope

```yaml
apiVersion: argoproj.io/v1alpha1
kind: AppProject
metadata:
  name: my-project
  namespace: argocd
spec:
  sourceRepos:
    - https://github.com/example/repo.git
  destinations:
    - namespace: dev
      server: https://kubernetes.default.svc
  clusterResourceWhitelist:
    - group: ""
      kind: "Namespace"
```

## Resource Whitelists and Blacklists

To enforce governance, ArgoCD allows **whitelisting** and **blacklisting** resources at the project level.

### Example Whitelist Policy
```yaml
spec:
  clusterResourceWhitelist:
    - group: apps
      kind: Deployment
```

### Example Blacklist Policy
```yaml
spec:
  clusterResourceBlacklist:
    - group: networking.k8s.io
      kind: Ingress
```

These restrictions help enforce security policies, preventing unauthorized deployments of sensitive resources.

---
