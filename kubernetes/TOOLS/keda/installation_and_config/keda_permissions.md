# KEDA: RBAC and Permissions

## Understanding KEDA's Required Permissions
KEDA requires certain Kubernetes Role-Based Access Control (RBAC) permissions to monitor metrics, scale workloads, and interact with external event sources.

### 1. **ClusterRoles and RoleBindings**
KEDA typically requires cluster-wide permissions to function properly. The default installation includes:
- A **ClusterRole** with permissions to:
  - Read and watch `ScaledObjects`, `ScaledJobs`, and `TriggerAuthentications`.
  - Get and list deployments, jobs, and pods.
  - Access Kubernetes events.
- A **ClusterRoleBinding** that binds KEDA’s service account to the required ClusterRole.

#### Checking KEDA’s ClusterRole
To inspect KEDA’s current permissions, run:
```sh
kubectl get clusterrole keda-operator -o yaml
```

### 2. **Fine-Tuning Permissions**
For security-sensitive environments, you can restrict permissions by:
- **Using Role instead of ClusterRole**: Limits access to a specific namespace.
- **Creating Custom RoleBindings**: Assigns permissions only to necessary namespaces.

#### Example: Namespace-Scoped Role
If you want to restrict KEDA to a specific namespace (`my-namespace`):
```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: keda-namespace-role
  namespace: my-namespace
rules:
  - apiGroups: ["keda.sh"]
    resources: ["scaledobjects", "scaledjobs", "triggerauthentications"]
    verbs: ["get", "list", "watch"]
  - apiGroups: [""]
    resources: ["deployments", "pods", "events"]
    verbs: ["get", "list", "watch"]
```

#### Creating a RoleBinding
```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: keda-namespace-binding
  namespace: my-namespace
subjects:
  - kind: ServiceAccount
    name: keda-operator
    namespace: keda
roleRef:
  kind: Role
  name: keda-namespace-role
  apiGroup: rbac.authorization.k8s.io
```

### 3. **Validating KEDA’s Permissions**
To test permissions assigned to KEDA:
```sh
kubectl auth can-i list scaledobjects --as=system:serviceaccount:keda:keda-operator
```
If permissions are insufficient, refine the Role/ClusterRole definitions accordingly.

By fine-tuning RBAC permissions, KEDA can be restricted to only necessary namespaces, enhancing security while maintaining scalability.

---
