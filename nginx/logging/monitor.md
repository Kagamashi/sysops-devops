
## Prometheus and Grafana Monitoring

### Exporting NGINX Metrics to Prometheus
Enable the **`nginx-prometheus-exporter`** to expose NGINX metrics:
```bash
docker run -p 9113:9113 -d nginx/nginx-prometheus-exporter:latest -nginx.scrape-uri=http://localhost/nginx_status
```
- Runs an NGINX exporter on port **9113**, scraping metrics from `/nginx_status`.

#### Visualizing Data in Grafana
1. Add **Prometheus** as a data source in **Grafana**.
2. Import a **NGINX dashboard** from [Grafana dashboards](https://grafana.com/grafana/dashboards/).
3. Monitor **requests per second**, **active connections**, and **error rates** in real-time.

---

## Real-Time Debugging with `stub_status`

### Enabling `stub_status` for Active Connection Monitoring
```nginx
server {
    listen 80;
    server_name localhost;

    location /nginx_status {
        stub_status;
        allow 127.0.0.1;
        deny all;
    }
}
```
- **`stub_status`** → Enables real-time stats for active connections.
- **`allow 127.0.0.1;`** → Limits access to localhost.

### Checking NGINX Status
Run the following command to monitor active connections:
```bash
curl http://localhost/nginx_status
```
Output example:
```
Active connections: 5
server accepts handled requests
  12345 12345 67890
Reading: 1 Writing: 2 Waiting: 2
```
- **Active connections** → Number of active clients.
- **Reading/Writing/Waiting** → Breakdown of current request handling.
