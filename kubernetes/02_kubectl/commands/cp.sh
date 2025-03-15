
# Copy files and directories between a container in a Pod and your local filesystem.
kubectl cp [pod-name]:/path/to/source /local/path/to/destination
kubectl cp /local/path/to/source [pod-name]:/path/to/destination

# opy file from Pod to local
kubectl cp my-pod:/var/log/app.log /local/path/app.log

# copy directory from local to Pod
kubectl cp /local/path/dir my-pod:/container/path/dir

# Tips:
# - Useful for extracting logs, configurations, or debugging files from containers.
# - Ensure that the path is correct in the Pod (container) or on the local machine to avoid copy errors.

kubectl cp /tmp/foo_dir my-pod:/tmp/bar_dir            # Copy /tmp/foo_dir local directory to /tmp/bar_dir in a remote pod in the current namespace
kubectl cp /tmp/foo my-pod:/tmp/bar -c my-container    # Copy /tmp/foo local file to /tmp/bar in a remote pod in a specific container
kubectl cp /tmp/foo my-namespace/my-pod:/tmp/bar       # Copy /tmp/foo local file to /tmp/bar in a remote pod in namespace my-namespace
kubectl cp my-namespace/my-pod:/tmp/foo /tmp/bar       # Copy /tmp/foo from a remote pod to /tmp/bar locally

# advanced
tar cf - /tmp/foo | kubectl exec -i -n my-namespace my-pod -- tar xf - -C /tmp/bar    # Copy /tmp/foo local file to /tmp/bar in a remote pod in namespace my-namespace
kubectl exec -n my-namespace my-pod -- tar cf - /tmp/foo | tar xf - -C /tmp/bar       # Copy /tmp/foo from a remote pod to /tmp/bar locally
