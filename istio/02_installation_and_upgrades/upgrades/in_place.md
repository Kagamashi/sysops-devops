
https://istio.io/latest/docs/setup/upgrade/in-place/

---

## In-Place Upgrade
1. **Download the appropriate `istioctl` version:**
   ```bash
   <extracted-dir>/bin/istioctl operator init
   ```

2. **Verify the Istio Operator upgrade:**
   Check that the Istio operator restarts and updates to the target version:
   ```bash
   kubectl get pods --namespace istio-operator \
     -o=jsonpath='{range .items[*]}{.metadata.name}{":\t"}{range .spec.containers[*]}{.image}{", "}{end}{"\n"}{end}'
   ```

3. **Verify Control Plane upgrade:**
   After a minute or two, Istio control plane components should restart with the new version:
   ```bash
   kubectl get pods --namespace istio-system \
     -o=jsonpath='{range .items[*]}{"\n"}{.metadata.name}{":\t"}{range .spec.containers[*]}{.image}{", "}{end}{"\n"}{end}'
   ```

---

For minimal changes and downtime:
- Perform an in-place upgrade using the following steps:
  ```bash
  istioctl upgrade --help
  istioctl upgrade --dry-run
  istioctl upgrade
  ```
- Verify the control plane and sidecars:
  ```bash
  kubectl get pods -n istio-system
  kubectl get mutatingwebhookconfigurations
  ```

---
