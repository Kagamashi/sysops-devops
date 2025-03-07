## Installation
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

sudo apt update && sudo apt install helm -y


## HELM cli
helm version
helm help

# generates a boilerplate Helm chart structure
  # creates new directory my-chart/ with default templates
helm create my-chart

# installing Helm chart
  # my-release - unique name for installed release
  # ./mychart - path to Helm chart directory
helm install my-release ./mychart
helm upgrade my-release ./mychart --set replicaCount=3 # applies changes while preserving existing settings
helm upgrade my-release ./mychart --atomic # rollback automatically on failure
helm upgrade my-release ./mychart --version 1.2.3 # version constraints
helm uninstall my-release


helm list # listing installed releases
helm search repo nginx # finds Nginx-related Helm charts in configured repositories


helm repo list # displays all configured Helm repositories
helm repo add stable https://charts.helm.sh/stable # adds repository from which carts can be installed
helm repo update  # fetches latest chart versions from all repositories

helm push mychart/ oci://my-private-repo # push/pull charts from private repository (requires authentication)

helm history # view release history
helm rollback my-release 1 # rollbacks to revision 1 of the release
helm rollback my-release --force # if deployment is stuck, force a rollback

helm template my-release mychart/ # validate template and check syntax
