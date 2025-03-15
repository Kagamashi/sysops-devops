
## Data Plane Upgrade
- Ensure the data plane (Envoy proxies) matches the control plane version by restarting application pods:
  ```bash
  kubectl rollout restart deployment -n <namespace>
  ```
- Verify that the updated proxies are using the correct revision:
  ```bash
  istioctl proxy-status | grep "\.test-ns "
  ```

---
