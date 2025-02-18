
# installing Helm chart

#  - my-release is the custom name for this deployment.
#  - bitnami/nginx is the Helm Chart name from the Bitnami repository.
helm install my-release bitnami/nginx

# display all deployed Helm releases into the cluster
helm list

# uninstall a release
helm uninstall my-release
