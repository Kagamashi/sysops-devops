
# Add Helm repo
helm repo add kedacore https://kedacore.github.io/charts

# Update Helm repo
helm repo update

# Install keda Helm chart
helm install keda kedacore/keda --namespace keda --create-namespace


## Uninstall
# First remove any ScaledObjects and ScaledJobs that were created
kubectl delete $(kubectl get scaledobjects.keda.sh,scaledjobs.keda.sh -A \
  -o jsonpath='{"-n "}{.items[*].metadata.namespace}{" "}{.items[*].kind}{"/"}{.items[*].metadata.name}{"\n"}')
helm uninstall keda -n keda

# If ScaledObjects and ScaledJobs were not removed the resources will become orphaned and need to be patched
for i in $(kubectl get scaledobjects -A \
  -o jsonpath='{"-n "}{.items[*].metadata.namespace}{" "}{.items[*].kind}{"/"}{.items[*].metadata.name}{"\n"}');
do kubectl patch $i -p '{"metadata":{"finalizers":null}}' --type=merge
done

for i in $(kubectl get scaledjobs -A \
  -o jsonpath='{"-n "}{.items[*].metadata.namespace}{" "}{.items[*].kind}{"/"}{.items[*].metadata.name}{"\n"}');
do kubectl patch $i -p '{"metadata":{"finalizers":null}}' --type=merge
done

