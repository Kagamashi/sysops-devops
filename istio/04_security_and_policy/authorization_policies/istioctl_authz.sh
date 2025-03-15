
# Analyzes authorization policies applied to a specific workload, showing requests that are allowed or denied based on the policies.

istioctl x authz check <pod-name> --namespace <namespace>
istioctl x authz list --workload <workload-name> --namespace <namespace>

