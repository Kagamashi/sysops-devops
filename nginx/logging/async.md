
## Async Processing and HTTP/2

### Enabling HTTP/2
HTTP/2 improves website performance with multiplexing, header compression, and faster request handling.
```nginx
server {
    listen 443 ssl http2;
    server_name example.com;
    ssl_certificate /etc/letsencrypt/live/example.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/example.com/privkey.pem;
}
```
- **`http2`** → Enables HTTP/2 for improved performance.

### Performance Enhancements for HTTP/2
Optimize HTTP/2 with tuning directives.
```nginx
http {
    sendfile on;
    tcp_nopush on;
    tcp_nodelay on;
    keepalive_timeout 65;
    types_hash_max_size 2048;
    client_body_buffer_size 10K;
    large_client_header_buffers 4 16k;
}
```
- **`sendfile on;`** → Enables efficient file transfer.
- **`tcp_nopush on;`** → Reduces packet overhead.
- **`tcp_nodelay on;`** → Prevents delays in small data transmissions.
- **`keepalive_timeout 65;`** → Maintains connections for 65 seconds to reduce handshakes.
- **`large_client_header_buffers`** → Increases buffer size for large HTTP headers.
