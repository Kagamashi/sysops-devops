
## TLS and SSL Configuration

### Enabling HTTPS with Let’s Encrypt
Let's Encrypt provides free SSL/TLS certificates for securing websites.
#### Install Certbot and Generate SSL Certificate (Ubuntu/Debian)
```bash
sudo apt update
sudo apt install certbot python3-certbot-nginx -y
sudo certbot --nginx -d example.com -d www.example.com
```
- **`certbot --nginx`** → Automatically configures NGINX for HTTPS.
- **`-d example.com -d www.example.com`** → Specifies domains for the SSL certificate.

#### Auto-Renew SSL Certificates
```bash
sudo certbot renew --dry-run
```
- This ensures SSL certificates are renewed before expiration.

### Redirecting HTTP to HTTPS
To force all HTTP traffic to HTTPS, add the following to your server block:
```nginx
server {
    listen 80;
    server_name example.com www.example.com;
    return 301 https://$host$request_uri;
}
```
- **`return 301 https://$host$request_uri;`** → Redirects all HTTP traffic to HTTPS.

### Enforcing HSTS (Strict Transport Security)
HTTP Strict Transport Security (HSTS) forces browsers to use HTTPS.
```nginx
server {
    listen 443 ssl;
    server_name example.com;
    ssl_certificate /etc/letsencrypt/live/example.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/example.com/privkey.pem;
    add_header Strict-Transport-Security "max-age=31536000; includeSubDomains; preload" always;
}
```
- **`max-age=31536000`** → Enforces HTTPS for one year.
- **`includeSubDomains`** → Applies to all subdomains.
- **`preload`** → Requests browser preload listing for HSTS.

### Optimizing SSL Configuration
To improve security and performance, use strong ciphers and protocols:
```nginx
ssl_protocols TLSv1.2 TLSv1.3;
ssl_ciphers "ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384";
ssl_prefer_server_ciphers on;
ssl_session_cache shared:SSL:10m;
ssl_session_timeout 10m;
ssl_stapling on;
ssl_stapling_verify on;
resolver 8.8.8.8 8.8.4.4;
```
- **`ssl_protocols`** → Enables only TLS 1.2 and 1.3 for security.
- **`ssl_ciphers`** → Uses strong cryptographic ciphers.
- **`ssl_stapling on;`** → Enables OCSP stapling for faster certificate validation.

---

## Security Headers

### Adding Security Headers
To enhance security, NGINX can send additional HTTP headers to protect against vulnerabilities.
```nginx
server {
    listen 80;
    server_name example.com;

    add_header X-Frame-Options "SAMEORIGIN" always;
    add_header X-XSS-Protection "1; mode=block" always;
    add_header X-Content-Type-Options "nosniff" always;
    add_header Referrer-Policy "strict-origin-when-cross-origin" always;
    add_header Permissions-Policy "geolocation=(), microphone=()" always;
    add_header Content-Security-Policy "default-src 'self'; script-src 'self' 'unsafe-inline';" always;
}
```
- **`X-Frame-Options SAMEORIGIN`** → Prevents clickjacking by disallowing page embedding on other sites.
- **`X-XSS-Protection 1; mode=block`** → Enables built-in XSS filtering in modern browsers.
- **`X-Content-Type-Options nosniff`** → Prevents MIME-type sniffing to mitigate certain attacks.
- **`Referrer-Policy strict-origin-when-cross-origin`** → Controls how much referrer info is sent.
- **`Permissions-Policy`** → Limits browser access to sensitive features.
- **`Content-Security-Policy`** → Restricts allowed sources of scripts, styles, and other content.

### Enabling CORS (Cross-Origin Resource Sharing)
CORS allows controlled access to resources from different origins.
```nginx
server {
    listen 80;
    server_name example.com;

    location /api/ {
        add_header Access-Control-Allow-Origin "*";
        add_header Access-Control-Allow-Methods "GET, POST, OPTIONS";
        add_header Access-Control-Allow-Headers "Authorization, Content-Type";
        if ($request_method = OPTIONS) {
            return 204;
        }
    }
}
```
- **`Access-Control-Allow-Origin "*"`** → Allows requests from any domain (adjust based on needs).
- **`Access-Control-Allow-Methods`** → Defines allowed request types.
- **`Access-Control-Allow-Headers`** → Specifies permitted headers.
- **Handles `OPTIONS` preflight requests** to avoid unnecessary server load.

### Disabling `server_tokens` (Hiding NGINX Version)
By default, NGINX exposes its version in response headers, which can be a security risk.
```nginx
server_tokens off;
```
- Prevents disclosure of the NGINX version in responses.

### Disabling Unnecessary Modules
Removing unused modules helps minimize attack surfaces and improve security.
#### Disable Unused HTTP Methods
```nginx
server {
    listen 80;
    server_name example.com;

    if ($request_method !~ ^(GET|POST|HEAD)$ ) {
        return 405;
    }
}
```
- Blocks unwanted HTTP methods like `DELETE`, `PUT`, `TRACE`, and `OPTIONS`.

#### Restrict Access to Hidden Files (e.g., `.git`, `.htaccess`)
```nginx
location ~ /\. {
    deny all;
}
```
- Prevents direct access to hidden files.

This configuration **strengthens security by adding protective headers, hiding sensitive info, and disabling unnecessary features**.
