# NGINX File Structure Overview

## What is NGINX?
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

## Installing NGINX

### Linux (Ubuntu/Debian)
```bash
sudo apt update
sudo apt install nginx -y
```

### macOS (Homebrew)
```bash
brew install nginx
```

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
