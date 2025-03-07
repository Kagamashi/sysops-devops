# Helm Security

## Chart Signing and Verification

Helm supports signing and verifying charts to ensure integrity and authenticity.

### **Creating a Signed Chart**
To sign a chart using GPG:
```bash
helm package mychart --sign --key "my-gpg-key" --keyring ~/.gnupg/pubring.gpg
```
- **`--sign`** → Signs the package.
- **`--key`** → Specifies the GPG key to use.
- **`--keyring`** → Specifies the keyring location.

This creates two files:
- `mychart-1.0.0.tgz`
- `mychart-1.0.0.tgz.prov` (provenance file)

### **Verifying a Chart**
To verify a downloaded chart:
```bash
helm verify mychart-1.0.0.tgz
```
- Confirms the signature and integrity of the chart.

---

## Helm Secrets and Encryption

### **Using Helm Secrets Plugin**
Helm does not encrypt `values.yaml` by default, but the `helm-secrets` plugin allows secure storage.

#### **Installing `helm-secrets` Plugin**
```bash
helm plugin install https://github.com/zendesk/helm-secrets
```

#### **Encrypting Secrets using SOPS**
```bash
sops --encrypt --in-place values.yaml
```
- Uses SOPS to encrypt sensitive values.
- The encrypted file is safe to store in Git.

#### **Using Encrypted Secrets in Helm**
```bash
helm secrets install my-release ./mychart -f secrets.enc.yaml
```
- Helm will decrypt the secrets before applying them.

---

## RBAC and Permissions

### **Ensuring Proper RBAC for Helm**
Helm interacts with Kubernetes through the user’s permissions. Set up **Role-Based Access Control (RBAC)** to prevent privilege escalation.

#### **Minimal RBAC for Helm Deployments**
Create a Role and RoleBinding:
```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: helm-deploy-role
  namespace: my-namespace
rules:
- apiGroups: ["*"]
  resources: ["deployments", "services", "configmaps", "secrets"]
  verbs: ["create", "update", "delete", "get", "list"]
```

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: helm-deploy-binding
  namespace: my-namespace
subjects:
- kind: User
  name: helm-user
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: Role
  name: helm-deploy-role
  apiGroup: rbac.authorization.k8s.io
```
- Ensures Helm users have limited permissions within a namespace.

### **Minimizing CI/CD Privileges**
When running Helm in CI/CD pipelines:
- Use **service accounts** with minimal permissions.
- Avoid granting full cluster-admin privileges.
- Restrict Helm access to specific namespaces.
