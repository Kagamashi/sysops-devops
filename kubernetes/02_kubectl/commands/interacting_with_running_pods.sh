
kubectl get pods -A                            # List all Pods across all namespaces
kubectl get pods -n <namespace>                # List Pods in a specific namespace
kubectl describe pod <pod-name> -n <namespace> # Get detailed information about a Pod
kubectl delete pod <pod-name> -n <namespace>   # Delete a specific Pod
kubectl logs <pod-name> -n <namespace>         # Retrieve logs of a Pod
kubectl logs -f <pod-name> -n <namespace>      # Stream logs (follow mode)
kubectl exec -it <pod-name> -n <namespace> -- /bin/sh  # Open a shell in a running Pod


# Display basic information about the Kubernetes cluster, including the API server address and core services.
kubectl cluster-info


# Execute a command inside a running container. This is commonly used for troubleshooting or inspecting running applications.
kubectl exec [pod-name] [-c [container-name]] -- [command]


# Create an ephemeral container or clone an existing Pod for debugging purposes. 
kubectl debug [pod-name] --image=[debug-image] --target=[container-name]
# --copy-to: Creates a new copy of the Pod for debugging.
# --image: Specifies the debug container image to use (e.g., busybox, alpine).
# --target: The target container in which to run the ephemeral container.
# --share-processes: Allows to see logs from other containers in the same Pod


# Print the logs of a container in a Pod. Useful for troubleshooting or monitoring the output of your applications.
kubectl logs [pod-name] [-c [container-name]]
# --tail: Show only the last N lines of logs.
# --follow/-f: Stream logs continuously as the container outputs them (like `tail -f`).
kubectl logs my-pod --follow
kubectl logs --since-time="timestamp" [name]

kubectl logs my-pod                                 # dump pod logs (stdout)
kubectl logs -l name=myLabel                        # dump pod logs, with label name=myLabel (stdout)
kubectl logs my-pod --previous                      # dump pod logs (stdout) for a previous instantiation of a container
kubectl logs my-pod -c my-container                 # dump pod container logs (stdout, multi-container case)
kubectl logs -l name=myLabel -c my-container        # dump pod container logs, with label name=myLabel (stdout)
kubectl logs my-pod -c my-container --previous      # dump pod container logs (stdout, multi-container case) for a previous instantiation of a container
kubectl logs -f my-pod                              # stream pod logs (stdout)
kubectl logs -f my-pod -c my-container              # stream pod container logs (stdout, multi-container case)
kubectl logs -f -l name=myLabel --all-containers    # stream all pods logs with label name=myLabel (stdout)
kubectl run -i --tty busybox --image=busybox:1.28 -- sh  # Run pod as interactive shell
kubectl run nginx --image=nginx -n mynamespace      # Start a single instance of nginx pod in the namespace of mynamespace
kubectl run nginx --image=nginx --dry-run=client -o yaml > pod.yaml
                                                    # Generate spec for running pod nginx and write it into a file called pod.yaml
kubectl attach my-pod -i                            # Attach to Running Container
kubectl port-forward my-pod 5000:6000               # Listen on port 5000 on the local machine and forward to port 6000 on my-pod
kubectl exec my-pod -- ls /                         # Run command in existing pod (1 container case)
kubectl exec --stdin --tty my-pod -- /bin/sh        # Interactive shell access to a running pod (1 container case)
kubectl exec my-pod -c my-container -- ls /         # Run command in existing pod (multi-container case)
kubectl debug my-pod -it --image=busybox:1.28       # Create an interactive debugging session within existing pod and immediately attach to it
kubectl debug node/my-node -it --image=busybox:1.28 # Create an interactive debugging session on a node and immediately attach to it
kubectl top pod                                     # Show metrics for all pods in the default namespace
kubectl top pod POD_NAME --containers               # Show metrics for a given pod and its containers
kubectl top pod POD_NAME --sort-by=cpu              # Show metrics for a given pod and sort it by 'cpu' or 'memory'
