
## **Helm v3 vs. v2 Differences**
With the release of Helm v3, significant changes were introduced, improving security, usability, and overall Kubernetes integration.

### **Key Differences Between Helm v2 and Helm v3**
| Feature | Helm v2 | Helm v3 |
|---------|---------|---------|
| **Tiller** | Required (installed in the cluster) | Removed (client-only architecture) |
| **RBAC Complexity** | Needed permissions for Tiller | Uses native Kubernetes RBAC |
| **CRDs** | Managed separately | Installed with charts automatically |
| **Chart Storage** | Stored in ConfigMaps | Uses OCI-compatible registries |
| **Release Namespaces** | Single namespace for releases | Release names scoped per namespace |
| **Secrets Handling** | Stored in ConfigMaps | Uses Secrets for better security |

### **Migration from Helm v2 to Helm v3**
If you are using Helm v2, migration to Helm v3 is required to benefit from security improvements and new features.

#### **Step 1: Install Helm 3 and the Migration Plugin**
```sh
helm plugin install https://github.com/helm/helm-2to3.git
```

#### **Step 2: Convert Helm v2 Releases to v3**
```sh
helm 2to3 convert my-release
```
This converts a Helm v2 release into a Helm v3 release while preserving history.

#### **Step 3: Clean Up Tiller and Helm v2 Data**
```sh
helm 2to3 cleanup
```
This removes all Helm v2 configurations and the Tiller component from the cluster.

---
