
## Choosing a Namespace
- **Default:** `keda`
- **Custom Namespace:** If using a different namespace, ensure all KEDA resources are installed in the same namespace.
  ```sh
  helm install keda kedacore/keda --namespace custom-namespace
  ```
  ```sh
  kubectl apply -n custom-namespace -f keda.yaml
  ```

---
