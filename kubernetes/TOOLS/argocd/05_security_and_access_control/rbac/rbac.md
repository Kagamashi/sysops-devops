### Role-Based Access Control (RBAC) in ArgoCD

ArgoCD RBAC policies are managed via the `argocd-rbac-cm` ConfigMap, located in the `argocd` namespace.

#### Example: ConfigMap for RBAC Policies
```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: argocd-rbac-cm
  namespace: argocd
data:
  policy.csv: |
    p, role:admin, applications, *, */*, allow
    p, role:dev, applications, get, */*, allow
    p, role:viewer, applications, get, argocd/*, allow
    g, admin@example.com, role:admin
    g, dev@example.com, role:dev
    g, viewer@example.com, role:viewer
```

#### Scoped RBAC to Specific Projects
RBAC in ArgoCD can be scoped to specific projects so users can only access applications within a particular project.

**Example: Scoped RBAC for a Project**
```yaml
apiVersion: argoproj.io/v1alpha1
kind: AppProject
metadata:
  name: example-project
spec:
  roles:
  - name: dev-role
    policies:
    - p, role:dev-role, applications, *, example-project/*, allow
  - name: viewer-role
    policies:
    - p, role:viewer-role, applications, get, example-project/*, allow
```

---
