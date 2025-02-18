
## **Installing and Configuring Cloudflared**
Cloudflared is the lightweight daemon that establishes secure tunnels between Cloudflare and your internal applications.

### **Installation**
#### **Linux:**
```sh
curl -fsSL https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 -o cloudflared
chmod +x cloudflared
sudo mv cloudflared /usr/local/bin/
```

---
