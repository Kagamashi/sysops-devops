kubectl create namespace argocd 
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Expose ArgoCD UI - multiple ways:
kubectl port-forward svc/argocd-server -n argocd 8080:443 https://localhost:8080
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'

# Initial password is auto-generated in secret argocd-initial-admin-secret
argocd admin initial-password -n argocd
argocd login [ARGOCD_SERVER]
argocd account update-password

# Register cluster
kubectl config get-contexts -o name

# This command adds SA 'argocd-manager' and binds it to 'admin-level' ClusterRole
# get, list, watch privileges are required at cluster scope for ArgoCD to function properly
argocd cluster add [CLUSTER_CONTEXT]

# Create APP from repository
kubectl config set-context --curent --namespace=argocd
argocd app create questbook --repo https://github.com/argoproj/argocd-example-apps.git --path guestbook --dest-server https://kubernetes.default.svc --dest-namespace default

# Sync the app
argocd app get guestbook
argocd app sync guestbook

---

# download the cli
brew install argocd
