
## **Configuring Secure SSH/RDP Tunnels**
Cloudflare Zero Trust enables secure SSH and RDP access to internal servers **without exposing ports to the internet**.

### **Step 1: Install Cloudflare Tunnel on the Target Machine**
```sh
curl -fsSL https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 -o cloudflared
chmod +x cloudflared
sudo mv cloudflared /usr/local/bin/
cloudflared service install
```

### **Step 2: Create a Secure Tunnel**
```sh
cloudflared tunnel create my-ssh-tunnel
```

### **Step 3: Configure Tunnel for SSH Access**
```yaml
hostname: ssh.example.com
service: ssh://localhost:22
```

### **Step 4: Update Cloudflare DNS**
- Add a **CNAME record** pointing `ssh.example.com` to Cloudflare’s tunnel ID.

### **Step 5: Enforce Identity-Based Access**
- Apply an **Access Policy** for SSH.
- Restrict access to authorized users through **Azure AD or Okta**.

---
