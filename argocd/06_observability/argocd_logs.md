**# Logging and Debugging Commands in ArgoCD**

## Where to Check Logs

ArgoCD components generate logs that help diagnose deployment issues. The key components include:

### **1. ArgoCD Server Logs**
- Handles API requests and authentication.
- View logs using:
  ```sh
  kubectl logs -n argocd deployment/argocd-server
  ```

### **2. ArgoCD Repo Server Logs**
- Manages Git operations, such as cloning and retrieving manifests.
- View logs using:
  ```sh
  kubectl logs -n argocd deployment/argocd-repo-server
  ```

### **3. ArgoCD Application Controller Logs**
- Monitors and synchronizes applications between Git and the cluster.
- View logs using:
  ```sh
  kubectl logs -n argocd deployment/argocd-application-controller
  ```

## ArgoCD CLI Debugging Commands

ArgoCD provides CLI tools for inspecting applications and troubleshooting issues.

### **1. Check Application Status**
```sh
argocd app get <app-name>
```

### **2. View Application Logs**
```sh
argocd app logs <app-name>
```

### **3. Show Application Sync History**
```sh
argocd app history <app-name>
```

### **4. Force Application Resync**
```sh
argocd app sync <app-name>
```

### **5. Manually Refresh Application State**
```sh
argocd app refresh <app-name>
```

### **6. Describe Events Related to an Application**
```sh
kubectl get events -n <namespace> --field-selector involvedObject.name=<app-name>
```

By using these logs and CLI commands, teams can efficiently debug and resolve ArgoCD application deployment issues.

---
