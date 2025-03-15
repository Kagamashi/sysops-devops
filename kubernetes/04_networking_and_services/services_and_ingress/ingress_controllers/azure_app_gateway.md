
## **Azure Application Gateway Ingress Controller**

### **Overview**
The **Azure Application Gateway Ingress Controller (AGIC)** is a Kubernetes-native ingress controller designed for **AKS (Azure Kubernetes Service)**. Unlike traditional ingress controllers that rely on in-cluster proxies, **AGIC integrates directly with Azure’s Application Gateway**, leveraging its built-in **load balancing, security, and monitoring** features.

### **Key Features**
- **Native Azure Load Balancer Integration**: Directly integrates with **Azure Application Gateway**, reducing operational overhead.
- **SSL/TLS Termination**: Supports secure traffic management with **Azure Key Vault** for certificate management.
- **Web Application Firewall (WAF) Support**: Provides advanced security protections against threats and attacks.
- **Autoscaling & High Availability**: Scales automatically with demand without manual intervention.
- **Path-based and Host-based Routing**: Routes traffic based on domain names or request paths.
- **Multi-site Ingress Support**: Allows multiple applications to use a single **Application Gateway**.

### **Example: Deploying Azure Application Gateway Ingress Controller**
```bash
helm repo add application-gateway-kubernetes-ingress https://appgwingress.blob.core.windows.net/ingress-azure-helm-packages/
helm install ingress-azure application-gateway-kubernetes-ingress/ingress-azure \
    --namespace kube-system \
    --set appgw.subscriptionId=<AZURE_SUBSCRIPTION_ID> \
    --set appgw.resourceGroup=<RESOURCE_GROUP> \
    --set appgw.name=<APP_GATEWAY_NAME> \
    --set appgw.shared=true
```

### **Example: Azure Application Gateway Ingress Resource**
```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: azure-ingress
  annotations:
    kubernetes.io/ingress.class: azure/application-gateway
spec:
  rules:
  - host: my-app.example.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: my-service
            port:
              number: 80
```

### **When to Use Azure Application Gateway Ingress Controller?**
- For **Azure-hosted Kubernetes clusters (AKS)** needing native load balancing.
- When requiring **TLS termination with Azure Key Vault integration**.
- To utilize **Web Application Firewall (WAF)** for additional security.
- For **multi-region, multi-site routing** within Azure cloud environments.
- When **autoscaling ingress capacity** is required without managing in-cluster resources.

---
