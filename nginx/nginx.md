# NGINX

NGINX is a high-performance, open-source web server, reverse proxy, and load balancer. It is designed to handle high concurrency with low memory usage and is known for its efficiency in serving static content and managing HTTP traffic.

## Where is NGINX Used?
- Web servers to host websites and applications.
- Reverse proxy to distribute client requests to backend servers.
- Load balancer to evenly distribute traffic among multiple backend instances.
- API gateway for microservices architectures.
- Caching layer to improve performance and reduce backend load.
- SSL/TLS termination for secure connections.

## What Can NGINX Do?
- Serve static and dynamic content.
- Reverse proxy requests to backend services.
- Load balance traffic with various algorithms.
- Act as an API gateway.
- Provide content caching.
- Implement security features like rate limiting and authentication.

## Tools Similar to NGINX
| Tool | Description |
|------|-------------|
| Apache HTTP Server | Another popular web server with a flexible module system. |
| HAProxy | Specialized in high-performance load balancing. |
| Caddy | Web server with automatic HTTPS and ease of use. |
| Traefik | Cloud-native reverse proxy with dynamic configuration. |

---

## `/etc/nginx/` Directory Structure

| Path                     | Description |
|--------------------------|-------------|
| `/etc/nginx/nginx.conf`  | Main configuration file |
| `/etc/nginx/sites-available/` | Available virtual host configurations |
| `/etc/nginx/sites-enabled/` | Active virtual host configurations (symlinked from `sites-available/`) |
| `/etc/nginx/conf.d/` | Additional configuration files (commonly used for modular setups) |
| `/etc/nginx/snippets/` | Reusable configuration snippets (e.g., SSL settings) |
| `/var/log/nginx/access.log` | Access log file |
| `/var/log/nginx/error.log` | Error log file |

---

## Open-Source vs. NGINX Plus

| Feature                | NGINX Open Source | NGINX Plus |
|------------------------|------------------|------------|
| Reverse Proxy         | ✅                | ✅          |
| Load Balancing       | ✅                | ✅          |
| SSL/TLS Termination  | ✅                | ✅          |
| Advanced Monitoring  | ❌                | ✅          |
| Active Health Checks | ❌                | ✅          |
| High Availability    | ❌                | ✅          |
| Web Application Firewall | ❌           | ✅          |

NGINX Plus provides additional enterprise-grade features like dynamic reconfiguration, enhanced monitoring, and official support.

---

Other topics..

## NGINX as an API Gateway

### Using NGINX for Microservices Routing
```nginx
server {
    listen 80;
    server_name api.example.com;

    location /service1/ {
        proxy_pass http://service1_backend;
    }
    location /service2/ {
        proxy_pass http://service2_backend;
    }
}
```
- Routes requests to different microservices based on the URL path.

### JWT Authentication
```nginx
location /secure-api/ {
    auth_jwt "Token Required";
    auth_jwt_key_file /etc/nginx/jwt.key;
    proxy_pass http://backend_api;
}
```
- **`auth_jwt`** → Enables JWT authentication.
- **`auth_jwt_key_file`** → Specifies the JWT verification key.

### API Rate Limiting
```nginx
limit_req_zone $binary_remote_addr zone=api_limit:10m rate=5r/s;
server {
    location /api/ {
        limit_req zone=api_limit burst=10 nodelay;
        proxy_pass http://backend_api;
    }
}
```
- **Limits each IP to 5 requests per second** with a burst of 10.

---

## NGINX Unit Integration

NGINX Unit is a lightweight application server for running multiple languages.
#### Running Applications with NGINX Unit
```bash
curl -X PUT --data-binary '{
    "listeners": {
        "*:8080": {
            "application": "app1"
        }
    },
    "applications": {
        "app1": {
            "type": "python",
            "path": "/srv/app1/",
            "module": "wsgi"
        }
    }
}' http://localhost:8080/config
```
- Configures NGINX Unit to serve a Python **WSGI application**.

---

## Dynamic Modules and Plugins

#### Compiling and Using Third-Party Modules
To add a module (e.g., **`ngx_brotli`** for Brotli compression), compile NGINX with the module:
```bash
sudo apt install nginx-extras
```
Or dynamically load modules:
```nginx
load_module modules/ngx_http_brotli_filter_module.so;
load_module modules/ngx_http_brotli_static_module.so;
```
- **`load_module`** → Dynamically loads a compiled module.
