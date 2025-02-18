
# Installing ecctl
curl -L -O https://github.com/elastic/ecctl/releases/latest/download/ecctl-linux-amd64
chmod +x ecctl-linux-amd64
mv ecctl-linux-amd64 /usr/local/bin/ecctl

# Authenticating with Elastic Cloud
ecctl auth login --apikey <YOUR_API_KEY>

# Listing All Deployments
ecctl deployment list --format=json

# Creating a New Deployment
ecctl deployment create --name "my-cluster" --region "gcp-europe-west1" --deployment-template "aws-io-optimized-v2"

# Scaling a Deployment
ecctl deployment update --id <DEPLOYMENT_ID> --size 4g

# Deleting a Deployment
ecctl deployment delete --id <DEPLOYMENT_ID>
