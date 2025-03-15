
# Check current KEDA version:
kubectl get deployment -n keda keda-operator -o=jsonpath='{.spec.template.spec.containers[0].image}'
