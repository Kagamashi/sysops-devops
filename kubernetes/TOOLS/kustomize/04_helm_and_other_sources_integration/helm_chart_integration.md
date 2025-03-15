
## **Helm Chart Integration**
Kustomize supports integrating Helm charts using different approaches.

### **Legacy Approach: `helmChartInflationGenerator`**
This method was deprecated in Kustomize v4 but was used to render Helm charts before applying transformations.

#### **Example:**
```yaml
helmChartInflationGenerator:
  - name: my-app
    chartRepoUrl: https://charts.example.com
    chartName: my-chart
    chartVersion: 1.2.3
    releaseName: my-release
```

### **Modern Approach: Using `helm template` with Kustomize**
A better approach is to use Helm to render templates and apply Kustomize transformations.

#### **Example Workflow:**
1. **Render Helm Chart:**
   ```sh
   helm template my-release my-chart --namespace my-namespace > helm-rendered.yaml
   ```
2. **Use Kustomize to Apply Transformations:**
   ```yaml
   resources:
     - helm-rendered.yaml
   patches:
     - patch.yaml
   ```

### **Best Practices for Combining Helm and Kustomize**
- **Render Helm charts first** before applying Kustomize transformations.
- **Avoid `helm install` directly** in a GitOps workflow—use Helm’s `template` command.
- **Use overlays to manage environment-specific Helm values.**

---
