# Wait for a specific condition to be met for a resource. This is useful for scripting, ensuring that resources reach a desired state before proceeding with other operations.
kubectl wait [resource-type]/[resource-name] --for=[condition]

# wait for a Pod to be ready
kubectl wait pod/my-pod --for=condition=ready --timeout=60s

# wait for a Deployment to be available
kubectl wait deployment/my-deployment --for=condition=available

# --timeout: Specify a time limit for waiting (e.g., 30s, 1m).
kubectl wait pod/my-pod --for=condition=ready --timeout=90s

# Tips:
# - Use `kubectl wait` in scripts to ensure a resource is in a particular state before moving on to the next step. This is particularly useful for automating deployment processes.
# - Combine with `--timeout` to avoid waiting indefinitely if a resource never reaches the expected state.
