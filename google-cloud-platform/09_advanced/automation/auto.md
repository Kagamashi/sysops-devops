# Automation and Scripting

## 1. Overview
Google Cloud provides various command-line tools for **automating administrative tasks**, managing resources, and scripting workflows. Key tools include:
- **gcloud CLI** (Google Cloud SDK) for general GCP automation.
- **gsutil** for Cloud Storage operations.
- **bq CLI** for BigQuery management.

---

## 2. gcloud CLI Advanced Usage
The `gcloud` command-line tool enables **managing Google Cloud resources programmatically**.

### **1. Listing and Managing Resources**
```sh
# List all active projects
gcloud projects list

# List VM instances in a region
gcloud compute instances list --filter="zone:(us-central1-a)"

# Create a VM instance
gcloud compute instances create my-instance \
  --zone=us-central1-a \
  --machine-type=e2-medium \
  --image-project=debian-cloud \
  --image-family=debian-11
```

### **2. Automating IAM and Permissions**
```sh
# Assign a role to a user
gcloud projects add-iam-policy-binding my-project \
  --member="user:admin@example.com" \
  --role="roles/storage.admin"

# View IAM policies
gcloud projects get-iam-policy my-project
```

### **3. Automating Networking Tasks**
```sh
# Create a VPC network
gcloud compute networks create my-vpc --subnet-mode=custom

# Create a firewall rule to allow SSH
gcloud compute firewall-rules create allow-ssh \
  --network=my-vpc \
  --allow=tcp:22 \
  --source-ranges=0.0.0.0/0
```

---

## 3. gsutil: Cloud Storage Automation
The `gsutil` tool automates **Google Cloud Storage operations**.

### **1. Copying and Managing Objects**
```sh
# Upload a file to Cloud Storage
gsutil cp myfile.txt gs://my-bucket/

# Download a file
gsutil cp gs://my-bucket/myfile.txt .

# Synchronize a local directory with a Cloud Storage bucket
gsutil rsync -r ./local-dir gs://my-bucket
```

### **2. Setting Storage Bucket Policies**
```sh
# Make a bucket publicly readable
gsutil iam ch allUsers:objectViewer gs://my-bucket

# View bucket IAM policies
gsutil iam get gs://my-bucket
```

---

## 4. bq CLI: BigQuery Automation
The `bq` command-line tool is used for **managing datasets, tables, and running queries**.

### **1. Running Queries**
```sh
# Run a query and save results to a table
bq query --use_legacy_sql=false \
  --destination_table=my_dataset.my_table \
  'SELECT name, age FROM my_project.my_dataset.users WHERE age > 30'
```

### **2. Exporting and Importing Data**
```sh
# Export a BigQuery table to Cloud Storage
bq extract --destination_format=CSV my_dataset.my_table gs://my-bucket/data.csv

# Load a CSV file into BigQuery
bq load --source_format=CSV my_dataset.my_table gs://my-bucket/data.csv
```

---

## 5. Custom Scripts for Admin Tasks
Custom scripts automate **repetitive GCP tasks** and improve efficiency.

### **1. Script: Bulk Start/Stop Compute Instances**
```sh
#!/bin/bash
PROJECT_ID="my-project"
ZONE="us-central1-a"
ACTION=$1  # start or stop

if [[ "$ACTION" == "start" || "$ACTION" == "stop" ]]; then
  INSTANCES=$(gcloud compute instances list --project=$PROJECT_ID --filter="zone:$ZONE" --format="value(name)")
  for INSTANCE in $INSTANCES; do
    echo "$ACTION instance: $INSTANCE"
    gcloud compute instances $ACTION $INSTANCE --zone=$ZONE --quiet
  done
else
  echo "Usage: $0 start|stop"
fi
```

### **2. Script: Backup Cloud Storage to Another Bucket**
```sh
#!/bin/bash
SOURCE_BUCKET="my-source-bucket"
DEST_BUCKET="my-backup-bucket"
echo "Syncing $SOURCE_BUCKET to $DEST_BUCKET"
gsutil -m rsync -r gs://$SOURCE_BUCKET gs://$DEST_BUCKET
```

---

## 6. Final Checklist
✅ Use **gcloud CLI** for automating resource provisioning and IAM management.  
✅ Use **gsutil** for automating Cloud Storage operations.  
✅ Automate **BigQuery queries and dataset management** using `bq` CLI.  
✅ Write **custom Bash scripts** to simplify admin tasks.  
✅ Schedule recurring jobs using **Cloud Scheduler** or **cron jobs**.  

📌 **More Resources:** [Google Cloud SDK Documentation](https://cloud.google.com/sdk/docs/)

