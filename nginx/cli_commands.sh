# Installation
sudo apt update
sudo apt install nginx -y


nginx -v # shows version
nginx -V # shows installed version and compiled modules

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


# monitor error logs in real time
tail -f /var/log/nginx/error.log
