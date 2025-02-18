
# displays all configured Helm repositories
helm repo list

# adds Bitnami Helm repository to local Helm CLI
helm repo add bitnami https://charts.bitnami.com/bitnami

# fetches latest chart versions from all repositories
helm repo update

# finds Nginx-related Helm charts in configured repositories
helm search repo nginx