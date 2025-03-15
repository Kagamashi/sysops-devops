# Dataproc and Datalab

## 1. Overview
Google Cloud **Dataproc** is a managed service for running **Hadoop, Spark, and other big data frameworks**, while **Datalab** provides interactive Jupyter-based notebooks for data analysis and machine learning.

---

## 2. Dataproc: Managed Hadoop/Spark Clusters
Dataproc enables **fast, scalable, and cost-effective** execution of big data workloads.

### **Key Features**
- Supports **Apache Spark, Hadoop, Hive, and Presto**.
- **Autoscaling clusters** reduce cost by adding/removing nodes dynamically.
- Integrates with **Cloud Storage, BigQuery, and Vertex AI**.
- Provides **ephemeral clusters** for short-lived jobs.

### **1. Creating a Dataproc Cluster**
```sh
gcloud dataproc clusters create my-cluster \
  --region=us-central1 \
  --master-machine-type=n1-standard-4 \
  --worker-machine-type=n1-standard-4 \
  --num-workers=2
```

### **2. Submitting a Spark Job**
```sh
gcloud dataproc jobs submit spark \
  --cluster=my-cluster \
  --region=us-central1 \
  --class=org.apache.spark.examples.SparkPi \
  --jars=file:///usr/lib/spark/examples/jars/spark-examples.jar \
  -- 1000
```

### **3. Deleting an Ephemeral Cluster After Job Completion**
```sh
gcloud dataproc clusters delete my-cluster --region=us-central1
```

---

## 3. Datalab: Interactive Notebooks
Datalab is a **Jupyter-based environment** for data science, exploration, and visualization.

### **Key Features**
- **Preinstalled libraries** for BigQuery, Pandas, and TensorFlow.
- **Secure access to Cloud Storage and BigQuery**.
- **Version control integration** with Git.

### **1. Creating a Datalab Instance**
```sh
gcloud compute instances create my-datalab-instance \
  --zone=us-central1-a \
  --machine-type=n1-standard-2
```

### **2. Connecting to Datalab**
```sh
gcloud datalab connect my-datalab-instance
```

### **3. Running a BigQuery Query in Datalab (Python Example)**
```python
from google.cloud import bigquery
client = bigquery.Client()
query = "SELECT COUNT(*) FROM my_dataset.my_table"
result = client.query(query).to_dataframe()
print(result)
```

---

## 4. Best Practices
### **1. Dataproc Best Practices**
✅ Use **ephemeral clusters** for cost savings.  
✅ Store **job data in Cloud Storage** instead of HDFS.  
✅ Enable **autoscaling** to dynamically adjust cluster size.  
✅ Use **preemptible VMs** to reduce cost for non-critical workloads.  

### **2. Datalab Best Practices**
✅ Use **Cloud Storage buckets** for storing notebook data.  
✅ Leverage **BigQuery integration** for large dataset analysis.  
✅ Implement **IAM controls** to restrict notebook access.  
✅ Keep notebooks version-controlled with Git.  

📌 **More Resources:** [Google Cloud Dataproc Documentation](https://cloud.google.com/dataproc/docs/) | [Google Cloud Datalab Documentation](https://cloud.google.com/datalab/docs/)

