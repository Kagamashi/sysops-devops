
## Installation
# Ubuntu/Debian
sudo apt update
sudo apt install postgresql postgresql-contrib

# RHEL
sudo yum install -y postgresql-server postgresql-contrib
sudo postgresql-setup initdb
sudo systemctl start postgresql
sudo systemctl enable postgresql

# Docker 
docker run --name postgres-container -e POSTGRES_USER=myuser -e POSTGRES_PASSWORD=mypassword -d -p 5432:5432 postgres

# Kubernetes
kubectl create deployment postgres --image=postgres
kubectl expose deployment postgres --port=5432 --type=ClusterIP
