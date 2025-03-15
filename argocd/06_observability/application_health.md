# Health States in Kubernetes and ArgoCD

This guide provides an overview of the health states used in Kubernetes and ArgoCD, including built-in and custom health checks.

---

## Health States

### **Healthy**
- **Description**: The resource is fully operational and meets the desired state.
- **Example**: A Deployment is marked as healthy when all its replicas are up and running as expected.

### **Progressing**
- **Description**: The resource is being updated or created but is not yet fully operational.
- **Example**: A StatefulSet that is scaling up or rolling out an update might be marked as progressing.

### **Degraded**
- **Description**: The resource is not functioning correctly, and intervention may be required.
- **Example**: A Pod in `CrashLoopBackOff` or a Deployment that has failed to deploy its replicas.

### **Missing**
- **Description**: The resource is expected but is not found in the cluster.
- **Example**: ArgoCD expects a Deployment to exist, but it cannot find it in the cluster.

### **Suspended**
- **Description**: The resource is paused or intentionally not running.
- **Example**: A Job that has been manually suspended by an administrator.

### **Unknown**
- **Description**: The health status of the resource could not be determined.
- **Example**: A custom resource without a custom health check might be marked as "unknown."

---

## Built-in Health Checks

ArgoCD provides built-in health checks for standard Kubernetes resources:

- **Deployments**: Marked healthy when all replicas are available and the desired number of Pods are running.
- **StatefulSets**: Marked healthy when the desired number of replicas are running.
- **DaemonSets**: Marked healthy when all Pods are running on the appropriate nodes.
- **Services**: Marked healthy when the endpoints are correctly serving traffic.
- **Ingress**: Marked healthy when the desired number of ingress rules are correctly configured and active.

---

## Custom Health Checks

ArgoCD supports custom health checks written in **Lua**, a lightweight scripting language. These checks allow you to define health states for custom resources.

### Example: Custom Health Check for a CRD

#### ConfigMap Definition
```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: argocd-cm
  namespace: argocd
data:
  resource.customizations.health.customresourcedefinition/mycustomresource: |
    hs = {}
    if obj.status ~= nil then
      if obj.status.phase == "Running" then
        hs.status = "Healthy"
      elseif obj.status.phase == "Pending" then
        hs.status = "Progressing"
      else
        hs.status = "Degraded"
      end
    else
      hs.status = "Unknown"
    end
    return hs
```

#### Explanation:
- **`resource.customizations.health.customresourcedefinition/mycustomresource`**: Defines a custom health check for a CRD called `mycustomresource`.
- **Lua Script**:
  - Evaluates the `status.phase` field of the custom resource.
  - Marks the resource as:
    - **Healthy** if `status.phase` is `Running`.
    - **Progressing** if `status.phase` is `Pending`.
    - **Degraded** for any other phase.
  - Marks the resource as **Unknown** if `status` is unavailable.

---

