
# Check Installed Version
nginx -v

# Check Running Status
systemctl status nginx

sudo systemctl start nginx
sudo systemctl stop nginx
sudo systemctl restart nginx
sudo systemctl reload nginx # reload without restarting

# Control NGINX process manually
nginx -s stop       # immediately stops NGINX
nginx -s quit       # gracefully shuts down NGINX
nginx -s reload     # reloads config
nginx -s reopen     # reopen log files

# Test NGINX Configuration
nginx -t

