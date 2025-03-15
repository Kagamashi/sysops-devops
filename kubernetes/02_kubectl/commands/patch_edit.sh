
kubectl edit deployment <deployment-name>   # Open and modify the resource in an interactive editor
kubectl patch deployment <deployment-name> --type='json' -p '[{"op": "replace", "path": "/spec/replicas", "value": 5}]'

# Remove NodeAffinity from a pod
kubectl patch pod [name] -p '{"spec":{"affinity":{"nodeAffinity":null}}}'

# Partially update a node
kubectl patch node k8s-node-1 -p '{"spec":{"unschedulable":true}}'

# Update a container's image; spec.containers[*].name is required because it's a merge key
kubectl patch pod valid-pod -p '{"spec":{"containers":[{"name":"kubernetes-serve-hostname","image":"new image"}]}}'

# Update a container's image using a json patch with positional arrays
kubectl patch pod valid-pod --type='json' -p='[{"op": "replace", "path": "/spec/containers/0/image", "value":"new image"}]'

# Disable a deployment livenessProbe using a json patch with positional arrays
kubectl patch deployment valid-deployment  --type json   -p='[{"op": "remove", "path": "/spec/template/spec/containers/0/livenessProbe"}]'

# Add a new element to a positional array
kubectl patch sa default --type='json' -p='[{"op": "add", "path": "/secrets/1", "value": {"name": "whatever" } }]'

# Update a deployment's replica count by patching its scale subresource
kubectl patch deployment nginx-deployment --subresource='scale' --type='merge' -p '{"spec":{"replicas":2}}'


# EDITING
# Edit a resource on the server directly, opens the resource in your default text editor.
kubectl edit [resource-type] [resource-name]
# --record: Record the command in the resource's annotations (good for auditing).
kubectl edit deployment my-deployment --record

kubectl edit svc/docker-registry                      # Edit the service named docker-registry
KUBE_EDITOR="nano" kubectl edit svc/docker-registry   # Use an alternative editor
