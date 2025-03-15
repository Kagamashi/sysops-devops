
kubectl cordon my-node                                                # Mark my-node as unschedulable
kubectl drain my-node                                                 # Drain my-node in preparation for maintenance
kubectl uncordon my-node                                              # Mark my-node as schedulable
kubectl top node                                                      # Show metrics for all nodes
kubectl top node my-node                                              # Show metrics for a given node
kubectl cluster-info                                                  # Display addresses of the master and services
kubectl cluster-info dump                                             # Dump current cluster state to stdout
kubectl cluster-info dump --output-directory=/path/to/cluster-state   # Dump current cluster state to /path/to/cluster-state

# View existing taints on which exist on current nodes.
kubectl get nodes -o='custom-columns=NodeName:.metadata.name,TaintKey:.spec.taints[*].key,TaintValue:.spec.taints[*].value,TaintEffect:.spec.taints[*].effect'

# If a taint with that key and effect already exists, its value is replaced as specified.
kubectl taint nodes foo dedicated=special-user:NoSchedule


kubeclt cordon/uncordon
# - Use `kubectl cordon` to prepare a node for maintenance, ensuring that no new Pods will be scheduled on the node.
# - Combine with `kubectl drain` to safely evict existing Pods for maintenance.

kubectl drain [node-name] --ignore-daemonsets --delete-emptydir-data
# - `kubectl drain` is useful for safely removing all Pods before performing maintenance or upgrades on the node.
# - Always use `--ignore-daemonsets`, as DaemonSet Pods are managed independently and should not be drained.

kubectl taint nodes [node-name] [key]=[value]:[effect]
# Tips:
# - Taints and tolerations are powerful tools to control Pod placement. Use them to reserve nodes for specific workloads or to prevent Pods from being scheduled on specific nodes.
# - The main effects are `NoSchedule`, `NoExecute`, and `PreferNoSchedule`, which determine how Pods are treated on tainted nodes.
