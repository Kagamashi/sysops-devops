## Helm

**Helm** is the **package manager for Kubernetes**, enabling easy deployment, versioning, and management of applications using **Helm Charts**.

- **Official Docs**: [https://helm.sh/docs/](https://helm.sh/docs/)
- **GitHub Repository**: [https://github.com/helm/helm](https://github.com/helm/helm)
- **Helm Chart Hub**: [https://artifacthub.io/](https://artifacthub.io/)
- **CLI Reference**: [https://helm.sh/docs/helm/](https://helm.sh/docs/helm/)

---

### Dictionary

- **Chart**: A package containing all Kubernetes manifests, templates, values, and metadata.
- **Release**: A deployed instance of a Helm chart in a Kubernetes cluster.
- **Repository**: A collection of Helm charts stored remotely or locally.
- **Values.yaml**: A configuration file that customizes Helm chart deployments.
- **Templates**: Kubernetes manifests written with Go templating, dynamically rendered during `helm install`.
- **Tiller**: Deprecated component (Helm v2) responsible for managing releases on the cluster (replaced by Helm v3).
- **OCI Registry**: Helm supports storing charts in OCI-compliant registries (e.g., Docker Hub, ACR, ECR).

---
