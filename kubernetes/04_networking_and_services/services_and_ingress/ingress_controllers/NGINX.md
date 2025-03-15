
## **NGINX Ingress Controller**

### **Overview**
The **NGINX Ingress Controller** is the most widely used Kubernetes ingress solution. It provides **reliable load balancing, path-based routing, and TLS termination** for applications inside a Kubernetes cluster.

### **Key Features**
- **Path-based and Host-based Routing**: Directs requests based on URL paths or hostnames.
- **SSL/TLS Termination**: Offloads TLS encryption and supports Let's Encrypt.
- **Rewrite and Redirection Support**: Allows URL rewrites and redirects.
- **Rate Limiting and Access Control**: Protects services from abuse.
- **gRPC and WebSockets Support**: Enables modern application protocols.
- **Canary Deployments**: Supports traffic splitting for testing new versions.
- **Integration with Prometheus**: Provides detailed metrics and observability.

### **Example: Deploying NGINX Ingress Controller**
```bash
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/cloud/deploy.yaml
```

### **Example: NGINX Ingress Resource**
```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: nginx-ingress
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
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

### **When to Use NGINX Ingress Controller?**
- When needing a **general-purpose** ingress solution.
- For applications requiring **TLS termination and security policies**.
- When requiring **path-based routing** for multiple services.
- In **production environments** needing **stability, scalability, and monitoring support**.

---
