
# https://kubernetes.io/docs/reference/kubectl/quick-reference/

source <(kubectl completion bash) # set up autocomplete in bash into the current shell, bash-completion package should be installed first.
echo "source <(kubectl completion bash)" >> ~/.bashrc # add autocomplete permanently to your bash shell.

alias k=kubectl
complete -o default -F __start_kubectl k

# short alias to set/show context/namespace (only works for bash and bash-compatible shells, current context to be set before using kn to set namespace)
alias kx='f() { [ "$1" ] && kubectl config use-context $1 || kubectl config current-context ; } ; f'
alias kn='f() { [ "$1" ] && kubectl config set-context --current --namespace $1 || kubectl config view --minify | grep namespace | cut -d" " -f6 ; } ; f'

---

# find all pods without Running status
kubectl get pods -A --no-headers | awk '$4 != "Running" {print $0}'

# get all pods in a namespace
kubectl get pods -n default -o json | jq -r '.items[].metadata.name'

# get node names and their status
kubectl get nodes -o json | jq -r '.items[] | {name: .metadata.name, status: .status.conditions[-1].type}'

# get all services with ClusterIP
kubectl get svc -o json | jq -r '.items[] | {name: .metadata.name, clusterIP: .spec.clusterIP}'

# watch pods IRL
watch kubectl get pods -A

# find all pods in CrashLoopBackOff
kubectl get pods --all-namespaces | grep CrashLoopBackOff

# run temporary pod for debugging
kubectl run debug --rm -it --image=busybox -- /bin/sh

# check cluster-wide events sorted by timestamp
kubectl get events --sort-by=.metadata.creationTimestamp -A

