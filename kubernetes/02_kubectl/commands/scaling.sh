#kubectl autoscale
# Automatically scale the number of Pods in a Deployment, ReplicaSet, or StatefulSet based on observed resource usage (CPU/memory).
# It creates a Horizontal Pod Autoscaler (HPA).
kubectl autoscale [resource-type]/[resource-name] --min=[min-replicas] --max=[max-replicas] --cpu-percent=[target-percentage]

# Example (scale a deployment based on CPU usage):
kubectl autoscale deployment/my-deployment --min=2 --max=10 --cpu-percent=80

# --min: Set the minimum number of replicas.
# --max: Set the maximum number of replicas.
# --cpu-percent: Target average CPU utilization across the Pods (as a percentage).

# Tips:
# - `kubectl autoscale` is useful for applications that experience variable load. Kubernetes will automatically adjust the number of Pods between the specified min and max limits based on resource usage.
# - You can monitor the status of autoscaling using `kubectl get hpa`.


# kubectl scale
# Scale a Deployment, ReplicaSet, or StatefulSet by adjusting the number of replicas.
kubectl scale [resource-type]/[resource-name] --replicas=[number]

# --timeout: Set the maximum time to wait for the scaling action to finish.
kubectl scale deployment/my-deployment --replicas=10 --timeout=60s
kubectl scale --replicas=3 rs/foo                                 # Scale a replicaset named 'foo' to 3
kubectl scale --replicas=3 -f foo.yaml                            # Scale a resource specified in "foo.yaml" to 3
kubectl scale --current-replicas=2 --replicas=3 deployment/mysql  # If the deployment named mysql's current size is 2, scale mysql to 3
kubectl scale --replicas=5 rc/foo rc/bar rc/baz                   # Scale multiple replication controllers
