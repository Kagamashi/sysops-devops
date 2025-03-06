## `nginx.conf`

## Structure
```nginx
user  www-data;
worker_processes auto;
error_log /var/log/nginx/error.log;
pid /run/nginx.pid;

events {
    worker_connections 1024;
}

http {
    include       /etc/nginx/mime.types;
    default_type  application/octet-stream;

    access_log /var/log/nginx/access.log;

    sendfile on;
    keepalive_timeout 65;

    include /etc/nginx/conf.d/*.conf;
    include /etc/nginx/sites-enabled/*;
}
```

## Key Sections
- **`user www-data;`** → Specifies the system user that runs NGINX processes. Common values: nginx, www-data, nobody
- **`worker_processes auto;`** → Controls number of worker processes NGINX spawns: auto allows NGINX to use the number of CPU cores. More processes can improve concurrency but increase resource consumption.
- **`pid /run/nginx.pid;`** → Defines the file storing NGINX process ID.
- **`events { ... }`**
  - **`worker_connections 1024;`** → Sets the max number of simultaneous connections per worker. Higher value increases the number of concurrent users NGINX can serve.
- **`http { ... }`** → Main HTTP configuration block.
  - **`include /etc/nginx/mime.types;`** → Defines supported file types.
  - **`include /etc/nginx/conf.d/*.conf;`** → Loads additional configurations (e.g. custom settings)
  - **`include /etc/nginx/sites-enabled/*;`** → Loads active virtual host configurations.
  - **`sendfile on;`** → Enables optimized file transfer.
  - **`keepalive_timeout 65;`** → Configures connection timeout.
- **`server { ... }`** → Defines how NGINX handles requests for specific domain or IP
  - **`listen 80;`** → Specified port NGINX listens on.
  - **`server_name example.com;`** → Defines domain or IP address this block handles.
  - **`root /var/www/html;`** → Sets root directory for this server.
  - **`index index.html;`** → Specifies the default file server when accessing the root.

- **`include`** directive loads configuration files dynamically.