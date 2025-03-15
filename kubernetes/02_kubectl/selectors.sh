
kubectl get pods -A --field-selector=status.phase=Running  # List only running Pods
kubectl get pods --selector=app=my-app   
