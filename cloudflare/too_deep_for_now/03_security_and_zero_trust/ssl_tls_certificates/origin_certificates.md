
## **Generating and Using Cloudflare Origin Certificates**
Cloudflare Origin Certificates allow Cloudflare to authenticate with your origin securely.

### **Step 1: Generate an Origin Certificate**
1. Go to **Cloudflare Dashboard → SSL/TLS → Origin Server**.
2. Click **Create Certificate**.
3. Choose **Cloudflare Origin CA Certificate**.
4. Select **Let Cloudflare generate a private key and CSR**.
5. Choose a validity period (e.g., `15 years`).
6. Add your domain names (`example.com, *.example.com`).
7. Click **Create Certificate**.
8. Copy the **certificate and private key**.

### **Step 2: Deploy the Certificate on Azure**
Depending on your infrastructure, you can deploy the Cloudflare Origin Certificate:

#### **Azure Application Gateway (HTTPS Listener)**
1. Upload the Cloudflare Origin Certificate as a **PFX** file:
   ```sh
   openssl pkcs12 -export -out cloudflare-origin.pfx -inkey private.key -in certificate.pem
   ```
2. In Azure Portal, go to **Application Gateway → Listeners**.
3. Add an HTTPS listener and upload the certificate.
4. Configure backend settings with HTTPS-only mode.

#### **Azure Kubernetes Service (AKS)**
1. Store the Cloudflare Origin Certificate in a Kubernetes secret:
   ```sh
   kubectl create secret tls cloudflare-tls --cert=certificate.pem --key=private.key -n ingress-nginx
   ```
2. Reference the secret in an **Ingress Controller TLS configuration**.

#### **Azure App Services (Custom Domain HTTPS)**
1. Navigate to **Azure App Service → Custom Domains → TLS/SSL Settings**.
2. Upload the certificate and bind it to the domain.

---
