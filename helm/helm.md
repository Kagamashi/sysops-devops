## **Helm**

Documentation: https://helm.sh/docs/

Releases: https://github.com/helm/helm/releases

---

Helm is a **package manager for Kubernetes** that simplifies deployment and management of applications using **Helm Charts**. It enables versioned and repeatable deployments.

### **Key Features:**
- **Chart-based deployments** for easy application management.
- **Templating system** for reusable Kubernetes manifests.
- **Rollback capabilities** for safer updates.
- **Dependency management** for multi-component applications.

---

## Helm v3 vs. v2 Differences

### **Key Changes in Helm v3**
1. **Tiller Removed** – Helm no longer requires a Tiller component in the cluster.
2. **Improved Security** – Helm v3 operates under the user’s native Kubernetes RBAC.
3. **Better Secrets Management** – Helm stores releases as Kubernetes secrets by default.
4. **Enhanced CRD Support** – Improved handling of Custom Resource Definitions (CRDs).
5. **New Commands & Changes**
   - `helm delete` → Now `helm uninstall`
   - `helm init` → Removed (no Tiller setup required)
   - `helm template` now supports direct rendering of templates without installing.


### **Migration from Helm v2 to Helm v3**
Install plugin
```sh
helm plugin install https://github.com/helm/helm-2to3.git
```

Convert Helm v2 release into a Helm v3 release while preserving history
```sh
helm 2to3 convert my-release
```

Remove all Helm v2 configurations and the Tiller component from the cluster
```sh
helm 2to3 cleanup
```

---
