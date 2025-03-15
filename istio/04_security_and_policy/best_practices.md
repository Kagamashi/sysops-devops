
## **Best Practices for Zero Trust and Least Privilege**
### **1. Deny by Default and Allow Selectively**
- Use a **deny-all policy** as a baseline.
- Explicitly allow required service-to-service communication.

### **2. Use mTLS for Strong Identity Verification**
- Combine **PeerAuthentication** with AuthorizationPolicy for workload identity enforcement.
- Ensure **STRICT** mTLS mode to prevent unverified plaintext access.

### **3. Apply Least Privilege Access Control**
- Grant **minimal permissions** for each service.
- Restrict **methods, paths, and sources** wherever possible.

### **4. Regularly Audit Policies**
- Use `istioctl x authz check` to verify policies.
- Monitor **access logs** to detect unauthorized access attempts.
