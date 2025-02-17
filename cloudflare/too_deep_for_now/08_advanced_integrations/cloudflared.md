
## **Installing and Configuring Cloudflared**
Cloudflared is the lightweight daemon that establishes secure tunnels between Cloudflare and your internal applications.

### **Installation (Linux/Mac/Windows)**
#### **Linux:**
```sh
curl -fsSL https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 -o cloudflared
chmod +x cloudflared
sudo mv cloudflared /usr/local/bin/
```
#### **Windows (via Chocolatey):**
```sh
choco install cloudflared
```

---
