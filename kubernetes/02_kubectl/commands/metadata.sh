# kubectl annotate
# Adds or updates the annotations on a resource.
kubectl annotate [resource-type] [resource-name] [annotation-key]=[value]

# --overwrite:  Allows overwriting an existing annotation.
kubectl annotate pod my-pod description="Updated pod" --overwrite

# Tips:
# - Use annotations to store metadata that can be used by tools or automation systems.


# kubectl label
# Add or update labels on a resource. Labels are key-value pairs used for selecting and grouping resources.
kubectl label [resource-type] [resource-name] [label-key]=[value]

# --overwrite: Allows updating an existing label.
kubectl label pod my-pod app=backend --overwrite

# Tips:
# - Labels are great for selecting subsets of resources (e.g., `kubectl get pods -l app=frontend`).
# - Combine with `kubectl get` or `kubectl delete` to select resources by labels.
