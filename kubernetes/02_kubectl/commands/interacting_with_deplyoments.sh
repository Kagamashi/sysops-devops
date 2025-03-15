
kubectl get deployments -A                     # List all Deployments
kubectl describe deployment <deployment-name>  # Get details of a Deployment
kubectl scale deployment <deployment-name> --replicas=5  # Scale Deployment
kubectl rollout status deployment <deployment-name>  # Check rollout status
kubectl rollout undo deployment <deployment-name>   # Roll back to the previous deployment

kubectl logs deploy/my-deployment                         # dump Pod logs for a Deployment (single-container case)
kubectl logs deploy/my-deployment -c my-container         # dump Pod logs for a Deployment (multi-container case)

kubectl port-forward svc/my-service 5000                  # listen on local port 5000 and forward to port 5000 on Service backend
kubectl port-forward svc/my-service 5000:my-service-port  # listen on local port 5000 and forward to Service target port with name <my-service-port>

kubectl port-forward deploy/my-deployment 5000:6000       # listen on local port 5000 and forward to port 6000 on a Pod created by <my-deployment>
kubectl exec deploy/my-deployment -- ls                   # run command in first Pod and first container in Deployment (single- or multi-container cases)


# Forward one or more local ports to a Pod. Useful for accessing applications running in the cluster without exposing them through a Service.
kubectl port-forward [pod-name] [local-port]:[pod-port]
