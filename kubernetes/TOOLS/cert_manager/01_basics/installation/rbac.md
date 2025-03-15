
## **RBAC and Permissions**
### **Cert-Manager Default Permissions**
Cert-Manager requires specific **Kubernetes Role-Based Access Control (RBAC)** permissions to create and manage certificates. By default, the Helm chart **creates the necessary roles and role bindings** in the `cert-manager` namespace.

To view the installed roles and permissions:
```sh
kubectl get role,rolebinding -n cert-manager
kubectl get clusterrole,clusterrolebinding | grep cert-manager
```

### **Customizing RBAC for Cert-Manager**
In some cases, you may want to restrict Cert-Manager's access or define custom RBAC rules. Below is an example of a **custom ClusterRole** with limited permissions.

#### **Example: Custom ClusterRole for Cert-Manager**
```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: cert-manager-custom-role
rules:
  - apiGroups: ["cert-manager.io"]
    resources: ["certificates", "certificaterequests", "issuers", "clusterissuers"]
    verbs: ["get", "list", "watch", "create", "update", "patch", "delete"]
```

#### **Example: Binding Custom Role to Cert-Manager Service Account**
```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: cert-manager-custom-binding
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cert-manager-custom-role
subjects:
  - kind: ServiceAccount
    name: cert-manager
    namespace: cert-manager
```
Apply the custom role and binding:
```sh
kubectl apply -f custom-clusterrole.yaml
kubectl apply -f custom-clusterrolebinding.yaml
```

### **Restricting Cert-Manager to a Specific Namespace**
By default, Cert-Manager operates across the cluster. To restrict it to a single namespace:
1. Use a **Role** instead of a **ClusterRole**.
2. Modify the Helm installation:
   ```sh
   helm install cert-manager jetstack/cert-manager \
     --namespace my-app-namespace \
     --set global.leaderElection.namespace=my-app-namespace
   ```

---
