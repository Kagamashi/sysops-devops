
# list ALL resources (loop through every api group)
kubectl api-resources --verbs=list --namespaced -o name \
  | xargs -n 1 kubectl get --show-kind --ignore-not-found -n dcp-product-lxaim # -l <label>=<value>