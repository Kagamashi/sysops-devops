
## Inventory Plugins and Dynamic Sources

Instead of manually listing hosts, **inventory plugins** can fetch hosts dynamically from cloud providers.

### **Using a Dynamic Inventory (AWS Example)**
1. Install AWS inventory plugin:
```bash
pip install boto3 botocore
```
2. Configure `inventory_aws.yaml`:
```yaml
plugin: amazon.aws.aws_ec2
regions:
  - us-east-1
filters:
  tag:Environment: dev
```
3. Run Ansible with dynamic inventory:
```bash
ansible-inventory -i inventory_aws.yaml --graph
```

Other cloud plugins include:
- **Azure** (`azure.azcollection.azure_rm`)
- **Google Cloud** (`google.cloud.gcp_compute`)
- **Kubernetes** (`community.kubernetes.k8s`)

---
