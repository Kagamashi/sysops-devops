
## **Automating Secret Rotation in Cert-Manager**
### **Periodic Secret Rotation with Kubernetes Jobs**
To automatically **rotate and refresh secrets**, you can schedule **Kubernetes Jobs**.

#### **Example: Rotating a Vault Token Every 7 Days**
```yaml
apiVersion: batch/v1
kind: CronJob
metadata:
  name: rotate-vault-token
  namespace: cert-manager
spec:
  schedule: "0 0 * * 7" # Every 7 days
  jobTemplate:
    spec:
      template:
        spec:
          containers:
          - name: rotate-token
            image: vault:latest
            command:
            - /bin/sh
            - -c
            - |
              new_token=$(vault token create -format=json | jq -r '.auth.client_token')
              kubectl create secret generic vault-secret --namespace cert-manager \
                --from-literal=token=$new_token --dry-run=client -o yaml | kubectl apply -f -
          restartPolicy: OnFailure
```
> **Note:** The method depends on your specific external issuer (e.g., HashiCorp Vault API for generating new tokens).

### **Best Practices for Secret Rotation**
| Best Practice | Benefit |
|--------------|---------|
| **Use short-lived credentials when possible** | Reduces security risk from credential leaks. |
| **Rotate secrets at regular intervals** | Minimizes downtime due to expired tokens. |
| **Automate secret updates using Kubernetes Jobs** | Ensures credentials remain fresh without manual intervention. |
| **Restrict access to Secrets via RBAC** | Prevents unauthorized access to sensitive data. |
| **Use Vault’s dynamic secrets feature** | Eliminates the need for long-lived credentials.

---
