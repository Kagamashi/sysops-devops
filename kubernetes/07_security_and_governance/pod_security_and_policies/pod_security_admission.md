
## Pod Security Admission (PSA)

Pod Security Admission (PSA) is the recommended mechanism for enforcing Pod security standards in Kubernetes. It provides **security profiles** that can be applied at the namespace level, ensuring that Pods in this namespace meet specific security requirements.

### **Key Features**:

#### 1. **Profiles**
- **Privileges**:
  - Allows all capabilities and provides minimal restrictions.
  - Suitable for trusted workloads that require high privileges.

- **Baseline**:
  - Provides moderate restrictions, suitable for general-purpose workloads.
  - Restricts the use of `HostNetwork` and `HostPID` to prevent Pods from accessing the underlying host's network or process namespaces.
  - Limits access to host paths, reducing the ability to mount host directories into containers.

- **Restricted**:
  - Enforces the most stringent security controls, ideal for highly sensitive workloads.
  - Requires the use of non-root containers by default.
  - Restricts access to `HostNetwork`, `HostPID`, and host paths, ensuring maximum isolation.

#### 2. **Namespace-Level Enforcement**
- Profiles are applied at the **namespace level**.
- All Pods in the namespace must conform to the selected profile.

#### 3. **Validation Modes**
- **Audit**: Logs violations but does not block the Pod.
- **Warn**: Provides warnings but allows the Pod to run.
- **Enforce**: Blocks the creation of Pods that violate the policy.

### **Applying PSA Profiles**
PSA profiles can be enforced on a namespace by applying specific labels:

- Apply the restricted security profile to a namespace:
  ```bash
  kubectl label namespace my-namespace pod-security.kubernetes.io/enforce=restricted
  ```

- Enable warnings for baseline profile violations:
  ```bash
  kubectl label namespace my-namespace pod-security.kubernetes.io/warn=baseline
  ```

- Enable auditing for privileged profile violations:
  ```bash
  kubectl label namespace my-namespace pod-security.kubernetes.io/audit=privileged
  ```

---
