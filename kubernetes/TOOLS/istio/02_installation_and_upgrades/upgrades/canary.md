
https://istio.io/latest/docs/setup/upgrade/canary/

---

## Canary Upgrade
The recommended way to upgrade Istio with zero downtime is by using **Canary Upgrades**. 

### Step 1: Install the Current Version
- Download and set up Istio 1.18.0:
  ```bash
  curl -L https://istio.io/downloadIstio | ISTIO_VERSION=1.18.0 sh -
  ```
- Deploy the operator with Istio 1.18.0:
  ```bash
  istio-1.18.0/bin/istioctl operator init
  ```
- Install the Istio control plane:
  ```bash
  kubectl apply -f - <<EOF
  apiVersion: install.istio.io/v1alpha1
  kind: IstioOperator
  metadata:
    namespace: istio-system
    name: example-istiocontrolplane-1-18-0
  spec:
    profile: default
  EOF
  ```
- Verify the IstioOperator CR:
  ```bash
  kubectl get iop --all-namespaces
  ```

### Step 2: Install the New Version
- Download and extract the `istioctl` version for the target Istio (e.g., 1.19.0):
  ```bash
  curl -L https://istio.io/downloadIstio | ISTIO_VERSION=1.19.0 sh -
  istio-1.19.0/bin/istioctl operator init --revision 1-19-0
  ```
- Create and modify the IstioOperator CR for 1.19.0:
  ```yaml
  apiVersion: install.istio.io/v1alpha1
  kind: IstioOperator
  metadata:
    namespace: istio-system
    name: example-istiocontrolplane-1-19-0
  spec:
    revision: 1-19-0
    profile: default
  ```
- Apply the updated CR:
  ```bash
  kubectl apply -f example-istiocontrolplane-1-19-0.yaml
  ```
- Verify side-by-side deployments:
  ```bash
  kubectl get pod -n istio-system -l app=istiod
  kubectl get services -n istio-system -l app=istiod
  ```
- Label namespaces to use the new revision:
  ```bash
  kubectl label namespace test-ns istio-injection- istio.io/rev=1-19-0
  kubectl rollout restart deployment -n test-ns
  ```

### Step 3: Remove Old Version
- Uninstall the old Istio control plane:
  ```bash
  kubectl delete istiooperators.install.istio.io -n istio-system example-istiocontrolplane-1-18-0
  ```
- Remove the old Istio operator:
  ```bash
  istioctl operator remove --revision 1-18-0
  ```
- Clean up remaining resources:
  ```bash
  istioctl uninstall -y --purge
  kubectl delete ns istio-system istio-operator
  ```

---
