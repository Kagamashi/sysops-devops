
## **Renewal Process and Expiration Checks**
### **Auto-Renewal Intervals**
- Certificates **renew automatically** based on the `renewBefore` field (default: 30 days before expiration).
- Cert-Manager checks for renewal needs periodically.

### **Verifying Certificate Status**
Check certificate details and expiration date:
```sh
kubectl describe certificate example-com-cert -n default
```
List all certificates and their conditions:
```sh
kubectl get certificate -A
```

### **Cert-Manager Logs for Renewal Events**
Monitor logs to debug renewal issues:
```sh
kubectl logs -n cert-manager -l app=cert-manager
```

### **Handling Failed Renewals**
Common issues causing renewal failures:
1. **ACME Challenge Errors**
   - Check if **DNS-01 or HTTP-01 validation** is correctly configured.
   - Inspect `Order` and `Challenge` resources:
   ```sh
   kubectl get challenges -A
   kubectl describe order <order-name> -n default
   ```
2. **DNS Misconfigurations**
   - Ensure the **DNS record exists and is propagated**.
   - Use `dig` or `nslookup` to verify DNS resolution:
   ```sh
   dig TXT _acme-challenge.example.com
   ```
3. **Secret or Issuer Issues**
   - Ensure the **Issuer or ClusterIssuer is valid**:
   ```sh
   kubectl get issuer,clusterissuer -A
   ```
   - Check if the **certificate secret exists**:
   ```sh
   kubectl get secret example-com-tls -n default
   ```

### **Manual Certificate Renewal**
If auto-renewal fails, force a manual renewal:
```sh
kubectl delete certificate example-com-cert -n default
kubectl apply -f certificate.yaml
```
This triggers Cert-Manager to **re-issue the certificate**.

---

## **Best Practices for Certificate Management**

| Best Practice | Benefit |
|--------------|---------|
| **Use `ClusterIssuer` for centralized certificate management** | Simplifies certificate issuance across namespaces. |
| **Use wildcard certificates only when necessary** | Reduces certificate management overhead, but increases security exposure. |
| **Set `renewBefore` at least 30 days before expiry** | Ensures timely certificate renewals. |
| **Monitor Cert-Manager logs and events** | Helps debug issues (`kubectl describe certificate <cert-name>`). |
| **Check DNS propagation for ACME challenges** | Prevents validation failures due to missing DNS records. |
| **Use Kubernetes Secrets for storing private keys** | Prevents unauthorized access to TLS credentials. |

For more details, visit **[Cert-Manager Documentation](https://cert-manager.io/docs/)**.
