
# Kyverno: Kubernetes-Native Policy Management

## **Introduction to Kyverno**
**Kyverno** is a Kubernetes-native policy engine designed for enforcing security and governance policies in Kubernetes clusters. Unlike OPA Gatekeeper, which uses **Rego**, Kyverno allows policies to be defined **using YAML**, making it more intuitive for Kubernetes users.

### **Why Use Kyverno?**
- **Kubernetes-native**: Uses YAML-based policies instead of requiring a new language like Rego.
- **Easier learning curve**: No need to learn a separate policy language.
- **Dynamic mutation & validation**: Supports modifying resource configurations dynamically.
- **Audit & enforcement**: Provides insight into policy violations without disrupting workloads.
- **Better integration with Kubernetes resources**: Works seamlessly with ConfigMaps, Secrets, and ServiceAccounts.

---

## **Key Components of Kyverno**
| Component | Description |
|-----------|-------------|
| **ClusterPolicy** | Policies applied cluster-wide. |
| **Policy** | Policies applied at the namespace level. |
| **Mutating Rules** | Modify resources at creation time. |
| **Validating Rules** | Block non-compliant resources. |
| **Generate Rules** | Automatically create required configurations. |
| **Policy Reports** | Track violations and enforce compliance. |

---

## **Installing Kyverno**
Kyverno runs as a **dynamic admission controller** in Kubernetes.

### **Step 1: Install Kyverno using Helm**
```bash
helm repo add kyverno https://kyverno.github.io/kyverno/
helm repo update
helm install kyverno kyverno/kyverno -n kyverno --create-namespace
```

### **Step 2: Verify Installation**
```bash
kubectl get pods -n kyverno
```
Expected output:
```
kyverno-xxxxx Running
```

---

## **Defining Kyverno Policies**
Kyverno policies use standard **Kubernetes YAML** syntax to define security rules.

### **1. Enforcing Pod Security Policies**
This example ensures that all Pods run as non-root users.

```yaml
apiVersion: kyverno.io/v1
kind: ClusterPolicy
metadata:
  name: enforce-non-root
spec:
  validationFailureAction: Enforce
  rules:
  - name: check-run-as-non-root
    match:
      resources:
        kinds:
        - Pod
    validate:
      message: "Running as root is not allowed."
      pattern:
        spec:
          securityContext:
            runAsNonRoot: true
```

### **2. Auto-Generating Network Policies**
Automatically generates a **NetworkPolicy** for each new namespace.

```yaml
apiVersion: kyverno.io/v1
kind: ClusterPolicy
metadata:
  name: generate-default-network-policy
spec:
  rules:
  - name: generate-network-policy
    match:
      resources:
        kinds:
        - Namespace
    generate:
      kind: NetworkPolicy
      apiVersion: networking.k8s.io/v1
      name: default-deny
      namespace: "{{request.object.metadata.name}}"
      data:
        spec:
          podSelector: {}
          policyTypes:
          - Ingress
          - Egress
```

### **3. Enforcing Image Signature Verification**
Prevents the deployment of unsigned container images.

```yaml
apiVersion: kyverno.io/v1
kind: ClusterPolicy
metadata:
  name: check-image-signature
spec:
  validationFailureAction: Enforce
  rules:
  - name: verify-signature
    match:
      resources:
        kinds:
        - Pod
    verifyImages:
    - image: "ghcr.io/myorg/*"
      key: "cosign.pub"
```

---

## **Audit Mode: Detecting Violations Without Enforcing Policies**
Kyverno can **audit existing resources** before enabling enforcement.

### **Enable Audit Mode**
```yaml
apiVersion: kyverno.io/v1
kind: ClusterPolicy
metadata:
  name: enforce-non-root
spec:
  validationFailureAction: Audit
  rules:
  - name: check-run-as-non-root
    match:
      resources:
        kinds:
        - Pod
    validate:
      message: "Running as root is not allowed."
      pattern:
        spec:
          securityContext:
            runAsNonRoot: true
```

### **View Policy Reports**
```bash
kubectl get polr -A
```

---

## **Best Practices for Kyverno**
| Best Practice | Benefit |
|--------------|---------|
| **Use Audit Mode first** | Detects policy violations before enforcing restrictions. |
| **Leverage Generate Rules** | Automates best practices like NetworkPolicies and default settings. |
| **Enforce Least Privilege** | Ensure Pods run with proper security settings. |
| **Regularly Monitor Policy Reports** | Identify security issues before they cause problems. |
| **Integrate with CI/CD** | Prevent misconfigurations from reaching production. |

---

## **Kyverno vs. OPA Gatekeeper**
| Feature | Kyverno | OPA Gatekeeper |
|---------|--------|---------------|
| **Policy Language** | YAML (Kubernetes-native) | Rego (custom syntax) |
| **Learning Curve** | Easy | Steep (requires learning Rego) |
| **Mutation Support** | Yes | No |
| **Generate Policies** | Yes | No |
| **Admission Control** | Yes | Yes |
| **Audit & Monitoring** | Yes | Yes |
| **Best Use Case** | Simple security policies & automation | Fine-grained, complex policy control |

---
