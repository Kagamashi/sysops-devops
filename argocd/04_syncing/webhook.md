# Webhooks in ArgoCD

Webhooks in ArgoCD are used to trigger immediate syncs when changes occur in the Git repository. Instead of waiting for the periodic reconciliation loop, webhooks enable faster response times to repository updates.

## Setting Up Webhooks

### 1. Configure a Webhook in Your Repository
- **URL**: `https://<ARGOCD_SERVER>/api/webhook`
- **Content Type**: `application/json`
- **Secret**: Set a secret key to secure your webhook.

### 2. Add Shared Secret in ArgoCD
Define the secret for webhook authentication in ArgoCD:
```yaml
apiVersion: v1
kind: Secret
metadata:
  name: argocd-webhook-secret
  namespace: argocd
data:
  webhook.secret: <BASE64_ENCODED_SECRET>
```

### 3. Enable Webhook Support in an Application
Add webhook support in your application definition:
```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: my-app
  namespace: argocd
spec:
  source:
    repoURL: https://github.com/my-org/my-app
    path: manifests/
  destination:
    server: https://kubernetes.default.svc
    namespace: production
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
    webhook:
      secretName: argocd-webhook-secret  # Use the shared secret for validation
```

---
