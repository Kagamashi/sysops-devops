
## **Ingress Controllers**
Kubernetes **Ingress Controllers** manage external HTTP/S access to Services within a cluster. An **Ingress** resource defines routing rules, while the Ingress Controller enforces them.

### **Common Ingress Controllers**
| **Ingress Controller** | **Features** | **Use Case** |
|------------------------|--------------|--------------|
| **NGINX Ingress** | Supports TLS termination, path-based routing, and load balancing. | General-purpose Ingress for most use cases. |
| **Traefik** | Lightweight, dynamic routing, automatic service discovery. | Edge routing, cloud-native environments. |
| **HAProxy Ingress** | High-performance, TCP and HTTP routing, load balancing. | Large-scale environments needing fine-grained traffic control. |
| **Contour** | Envoy-based, supports modern traffic management. | Advanced L7 traffic policies and performance optimizations. |
| **AWS/GCP/Azure Ingress** | Native cloud load balancer integrations. | Managed cloud environments with auto-scaling support. |

### **Example: Ingress Resource (NGINX)**
```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: my-ingress
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

### **Installing NGINX Ingress Controller**
```bash
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/cloud/deploy.yaml
```

### **When to Use Ingress?**
- When **multiple Services** need to be exposed through a single external IP.
- To enable **TLS termination** and secure communication.
- For **path-based and host-based routing**.
- To reduce dependency on external LoadBalancer services in cloud environments.

---
