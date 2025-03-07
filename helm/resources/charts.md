
## Chart Structure

A Helm chart is a collection of files that describe a set of Kubernetes resources.

### **Helm Chart Directory Structure**
When you create a new chart (`helm create mychart`), it follows this structure:
```
mychart/
 ├── charts/                 # Subcharts (dependencies)
 ├── templates/              # Kubernetes YAML templates
 │   ├── _helpers.tpl        # Helper template functions
 │   ├── deployment.yaml     # Deployment resource
 │   ├── service.yaml        # Service resource
 │   ├── ingress.yaml        # Ingress resource (if needed)
 ├── Chart.yaml              # Chart metadata (name, version, description)
 ├── values.yaml             # Default configuration values
 ├── LICENSE                 # (Optional) License information
 ├── README.md               # (Optional) Documentation
```

### **Key Files Explained**
- **`Chart.yaml`** → Defines chart metadata (name, description, version, appVersion).
- **`values.yaml`** → Default values used in templates (can be overridden).
- **`templates/`** → Contains the Kubernetes resource definitions with Helm templating.
- **`_helpers.tpl`** → Stores reusable template functions for labels and names.
- **`charts/`** → Stores chart dependencies (subcharts).

### **Best Practices for Naming and Versioning**
- Follow **semantic versioning** (`major.minor.patch`) in `Chart.yaml`.
- Keep **chart name simple and descriptive**.
- Use **appVersion** to indicate the application version, separate from chart version.

---
