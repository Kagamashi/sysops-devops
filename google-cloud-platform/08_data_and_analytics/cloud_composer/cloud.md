# Cloud Composer

## 1. Overview
Google Cloud Composer is a **fully managed workflow orchestration service** based on **Apache Airflow**. It enables users to define, schedule, and monitor workflows across multiple environments and services.

---

## 2. Airflow-Based Orchestration
Cloud Composer leverages **Apache Airflow DAGs (Directed Acyclic Graphs)** to automate task execution across **Google Cloud services, APIs, and on-prem environments**.

### **1. Key Features**
- **Managed Airflow environment** with automatic updates and scaling.
- **Integration with GCP services** (BigQuery, Dataflow, Pub/Sub, etc.).
- **Multi-environment support** for dev, staging, and production.
- **Security via IAM roles and VPC integration**.

### **2. Creating a Cloud Composer Environment**
```sh
gcloud composer environments create my-composer-env \
  --location=us-central1 \
  --zone=us-central1-a \
  --image-version=composer-2.0.30-airflow-2.3.4
```

### **3. Uploading a DAG to Cloud Composer**
```sh
gsutil cp my_dag.py gs://us-central1-my-composer-env-bucket/dags/
```

---

## 3. Workflow Scheduling
Cloud Composer schedules **Airflow DAGs** to run tasks in sequence or parallel based on dependencies.

### **1. Defining a Simple DAG**
```python
from airflow import DAG
from airflow.operators.dummy_operator import DummyOperator
from datetime import datetime

default_args = {
    'owner': 'airflow',
    'start_date': datetime(2024, 1, 1),
    'retries': 1,
}

dag = DAG('simple_dag', default_args=default_args, schedule_interval='@daily')

task1 = DummyOperator(task_id='start', dag=dag)
task2 = DummyOperator(task_id='end', dag=dag)

task1 >> task2  # Define task order
```

### **2. Triggering a DAG Manually**
```sh
gcloud composer environments run my-composer-env \
  --location=us-central1 \
  dags trigger simple_dag
```

### **3. Monitoring DAG Runs**
```sh
gcloud composer environments run my-composer-env \
  --location=us-central1 \
  dags list-runs simple_dag
```

---

## 4. Multi-Environment Deployment
Managing multiple Composer environments ensures **workflow isolation and version control** across development, staging, and production.

### **1. Creating a Staging Environment**
```sh
gcloud composer environments create staging-composer-env \
  --location=us-central1 \
  --image-version=composer-2.0.30-airflow-2.3.4
```

### **2. Promoting DAGs from Dev to Production**
- Use **Cloud Storage buckets** to sync DAGs between environments.
```sh
gsutil cp gs://dev-composer-bucket/dags/my_dag.py gs://prod-composer-bucket/dags/
```

### **3. Best Practices for Multi-Environment Management**
✅ Maintain **separate environments** for testing and production.  
✅ Use **Cloud Source Repositories or Git** for DAG version control.  
✅ Automate DAG deployment with **CI/CD pipelines**.  
✅ Implement **IAM roles** to control access to sensitive workflows.  

📌 **More Resources:** [Google Cloud Composer Documentation](https://cloud.google.com/composer/docs/)