
Policy library:
https://github.com/open-policy-agent/gatekeeper-library/tree/master/library

Azure Policies:
https://learn.microsoft.com/en-us/azure/governance/policy/concepts/policy-for-kubernetes

Documentation:
https://open-policy-agent.github.io/gatekeeper-library/website/

---

# OPA Gatekeeper: Kubernetes Policy Enforcement

## **Introduction to OPA Gatekeeper**
**OPA Gatekeeper** is a **policy controller** for Kubernetes that extends the **Open Policy Agent (OPA)** framework. It enforces **custom admission control policies** using **Rego**, a declarative policy language. Gatekeeper helps **secure Kubernetes clusters** by ensuring compliance, best practices, and security policies.

### **Why Use OPA Gatekeeper?**
- **Fine-grained control** over Kubernetes resource creation and modification.
- **Centralized policy enforcement** without modifying applications.
- **Preventive security** by rejecting non-compliant configurations before deployment.
- **Audit and monitoring capabilities** to track policy violations.

---

## **Key Components of OPA Gatekeeper**
| Component | Description |
|-----------|-------------|
| **Constraint Templates** | Defines reusable policy structures using **Rego**. |
| **Constraints** | Apply specific **Constraint Templates** to enforce policies. |
| **Gatekeeper Controller** | Ensures policies are enforced at the admission level. |
| **Audit Functionality** | Detects and reports violations of policies for existing resources. |

---

## **Installing OPA Gatekeeper**
Gatekeeper is deployed as a **Kubernetes Admission Controller**.

### **Step 1: Install Gatekeeper**
```bash
kubectl apply -f https://raw.githubusercontent.com/open-policy-agent/gatekeeper/master/deploy/gatekeeper.yaml
```

### **Step 2: Verify Installation**
```bash
kubectl get pods -n gatekeeper-system
```
Expected output:
```
gatekeeper-controller-manager-xxxxx Running
```

---

## **Defining OPA Policies with Constraint Templates and Constraints**

### **Step 3: Create a Constraint Template**
Defines a reusable policy using **Rego**.

```yaml
apiVersion: templates.gatekeeper.sh/v1beta1
kind: ConstraintTemplate
metadata:
  name: k8srequiredlabels
spec:
  crd:
    spec:
      names:
        kind: K8sRequiredLabels
  targets:
    - target: admission.k8s.gatekeeper.sh
      rego: |
        package k8srequiredlabels
        violation["label missing"] {
          not input.review.object.metadata.labels["app"]
        }
```

### **Step 4: Create a Constraint**
Applies the policy to enforce specific labels.

```yaml
apiVersion: constraints.gatekeeper.sh/v1beta1
kind: K8sRequiredLabels
metadata:
  name: require-app-label
spec:
  match:
    kinds:
      - apiGroups: [""]
        kinds: ["Pod"]
  parameters:
    labels: ["app"]
```

### **Step 5: Test Policy Enforcement**
Try creating a Pod **without** the `app` label.

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: test-pod
spec:
  containers:
  - name: nginx
    image: nginx
```

```bash
kubectl apply -f test-pod.yaml
```
Expected output:
```
Error from server (label missing): admission webhook "validation.gatekeeper.sh" denied the request
```

---

## **Audit Mode: Checking Policy Violations**
Gatekeeper can **audit existing resources** and detect violations **without blocking** deployments.

### **Enable Audit Mode**
```yaml
apiVersion: config.gatekeeper.sh/v1alpha1
kind: Config
metadata:
  name: config
spec:
  auditInterval: 60s  # Runs audit every 60 seconds
  constraintViolationsLimit: 20
```

### **View Audit Violations**
```bash
kubectl get constrainttemplates.constraints.gatekeeper.sh
```

---

## **Best Practices for OPA Gatekeeper**
| Best Practice | Benefit |
|--------------|---------|
| **Define policies as code** | Ensures reproducibility and version control. |
| **Use audit mode first** | Detects policy violations before enforcing rejections. |
| **Apply constraints incrementally** | Avoids disruptions by gradually applying policies. |
| **Leverage policy libraries** | Use predefined Gatekeeper policies for best practices. |
| **Integrate with CI/CD pipelines** | Enforce policies before deploying workloads. |

---

## **OPA Gatekeeper vs. Kyverno**
| Feature | OPA Gatekeeper | Kyverno |
|---------|---------------|--------|
| **Policy Language** | Rego (custom syntax) | YAML (Kubernetes-native) |
| **Learning Curve** | Steep (requires learning Rego) | Easy (familiar YAML syntax) |
| **Admission Control** | Yes | Yes |
| **Audit & Monitoring** | Yes | Yes |
| **Best Use Case** | Complex, fine-grained policies | Simple security policies |

---
