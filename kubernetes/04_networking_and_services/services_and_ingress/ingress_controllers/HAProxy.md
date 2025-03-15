
## **HAProxy Ingress Controller**

### **Overview**
The **HAProxy Ingress Controller** is a high-performance, feature-rich ingress controller that utilizes HAProxy as its underlying proxy technology. It is designed for **low latency, high throughput, and advanced load balancing** in Kubernetes environments.

### **Key Features**
- **Layer 4 (TCP) & Layer 7 (HTTP) Routing**: Supports both TCP and HTTP-based traffic routing.
- **Advanced Load Balancing**: Implements weighted load balancing, sticky sessions, and failover mechanisms.
- **SSL Termination & TLS Passthrough**: Handles HTTPS traffic securely, including mTLS authentication.
- **Rate Limiting & DDoS Protection**: Protects against abusive traffic patterns with rate limiting and connection controls.
- **Web Application Firewall (WAF) Support**: Can integrate with ModSecurity for enhanced security.
- **Dynamic Configuration**: Updates routes and backend services in real time without needing a restart.
- **Multi-Tenant Support**: Works efficiently in multi-namespace Kubernetes clusters.

### **Example: Deploying HAProxy Ingress Controller**
```bash
kubectl apply -f https://raw.githubusercontent.com/jcmoraisjr/haproxy-ingress/master/deploy/haproxy-ingress.yaml
```

### **Example: HAProxy Ingress Resource**
```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: haproxy-ingress
  annotations:
    haproxy.ingress.kubernetes.io/rewrite-target: /
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

### **When to Use HAProxy Ingress Controller?**
- When high-performance **Layer 4 & Layer 7 traffic routing** is required.
- For **enterprise-grade security** with built-in DDoS protection and WAF support.
- In **high-traffic production environments** needing **dynamic reconfiguration**.
- For **flexible TLS handling** with passthrough, termination, and mTLS authentication.

---
