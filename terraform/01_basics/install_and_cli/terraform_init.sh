
# initializes a Terraform working directory by downloading the necessary provider plugins and setting up the backend for state storage

terraform init
-backend=false  # disables backend initialization
-upgrade        # reinstalls latest version of provider plugins
