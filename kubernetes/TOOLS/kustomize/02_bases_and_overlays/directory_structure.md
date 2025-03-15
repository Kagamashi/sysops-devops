
## Directory Overview

```plaintext
my-app/
├── base/               # Common configurations shared across all environments
│   ├── deployment.yaml
│   ├── service.yaml
│   ├── kustomization.yaml
├── components/         # Modular, optional features like logging, monitoring, debugging
│   ├── logging/
│   │   ├── logging-config.yaml
│   │   └── kustomization.yaml
│   ├── monitoring/
│   │   ├── prometheus-config.yaml
│   │   └── kustomization.yaml
│   └── debug/
│       ├── debug-config.yaml
│       └── kustomization.yaml
├── overlays/           # Environment-specific customizations (e.g., dev, staging, prod)
│   ├── dev/
│   │   ├── kustomization.yaml
│   │   ├── dev-patch.yaml
│   ├── staging/
│   │   ├── kustomization.yaml
│   │   ├── staging-patch.yaml
│   └── prod/
│       ├── kustomization.yaml
│       ├── prod-patch.yaml
└── resources/          # Shared resources like Secrets, ConfigMaps, PVCs, Ingress definitions
    ├── secrets/
    │   ├── dev-secrets.yaml
    │   ├── staging-secrets.yaml
    │   ├── prod-secrets.yaml
    ├── configmaps/
    │   ├── app-config.yaml
    ├── pvc.yaml
    └── ingress.yaml
```

---

## Directory Details

### `base/` Directory
Contains common resources that are shared across all environments.
- These are the foundational configurations for your application (e.g., `Deployment`, `Service`).
- `kustomization.yaml` in this directory defines the shared resources.

**Example: `base/kustomization.yaml`**
```yaml
resources:
  - deployment.yaml
  - service.yaml

commonLabels:
  app: my-app
```

---

### `components/` Directory
Contains modular, reusable configurations that provide optional features (e.g., logging, monitoring, debugging).

**Example: `components/debug/kustomization.yaml`**
```yaml
resources:
  - debug-config.yaml
```

**Example: `components/debug/debug-config.yaml`**
```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: debug-config
data:
  log-level: debug
```

---

### `overlays/` Directory
Contains environment-specific customizations for dev, staging, and production. These configurations extend the `base/` directory using patches and transformations.

**Example: `overlays/dev/kustomization.yaml`**
```yaml
bases:
  - ../../base

components:
  - ../../components/debug
  - ../../components/logging

resources:
  - ../../resources/secrets/dev-secrets.yaml

patchesStrategicMerge:
  - dev-patch.yaml
```

**Example: `overlays/dev/dev-patch.yaml`**
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-app
spec:
  replicas: 1
  template:
    spec:
      containers:
        - name: my-app-container
          resources:
            limits:
              cpu: "500m"
              memory: "512Mi"
```

---

### `resources/` Directory
Contains shared Kubernetes resources that can be reused across multiple environments.

**Example: `resources/secrets/dev-secrets.yaml`**
```yaml
apiVersion: v1
kind: Secret
metadata:
  name: dev-secret
type: Opaque
data:
  api-key: YmFzZTY0LWVuY29kZWQ=
```

---
