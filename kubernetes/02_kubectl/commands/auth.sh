
# Inspect and verify authentication and authorization in the Kubernetes cluster. This is particularly useful for RBAC troubleshooting.
#   - can-i:      Check whether the current user has permission to perform a specific action.
#   - reconcile:  Ensure that RBAC roles and bindings match the current cluster state.
kubectl auth can-i create pods
kubectl auth reconcile -f rbac-config.yaml

# check user access
kubectl auth can-i create deployments --as dev-user

# check user access in specific namespace
kubectl auth can-i create deployments --as dev-user --namespace test

# Tips:
# - `kubectl auth can-i` is a very powerful command for verifying if a user or service account has the necessary permissions to perform an action.
# - Use `kubectl auth reconcile` to apply RBAC configurations idempotently, ensuring no accidental modifications to existing roles and bindings.
