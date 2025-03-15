## Kustomize

**Kustomize** is a configuration management tool for Kubernetes. It allows you to customize YAML manifests **without** forking them, using a **purely declarative approach**.

- **Official Docs**: [https://kubectl.docs.kubernetes.io/guides/introduction/kustomize/](https://kubectl.docs.kubernetes.io/guides/introduction/kustomize/)
- **GitHub Repository**: [https://github.com/kubernetes-sigs/kustomize](https://github.com/kubernetes-sigs/kustomize)
- **Kustomize CLI Install**: [https://kubectl.docs.kubernetes.io/installation/kustomize/](https://kubectl.docs.kubernetes.io/installation/kustomize/)
- **Kubernetes Integration**: Comes built into `kubectl` (e.g., `kubectl kustomize`).

---

### Dictionary (Key Kustomize Terms)

- **Base**: A reusable set of YAML manifests (e.g., Deployment, Service) that can be overlaid for different environments.
- **Overlay**: An environment-specific customization layer (like `dev`, `staging`, `production`). Overlays modify or add to the base.
- **kustomization.yaml**: The primary configuration file that defines resources, patches, common labels, etc.
- **Patch**: YAML snippet that modifies fields in the base resources (e.g., updating container images, replicas).
- **Strategic Merge Patch**: A patch style that merges fields for complex resources (like Deployments) while preserving existing YAML structure.
- **JSON 6902 Patch**: A more explicit patch format, used for complex or surgical changes.
- **Generators**: Kustomize plugins that generate secrets, configmaps, or other resources from files or literals.
