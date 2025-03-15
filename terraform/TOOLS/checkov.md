# Checkov: Terraform Security and Compliance Scanning

## **1. What is Checkov?**
Checkov is an **open-source static analysis tool** designed to scan infrastructure-as-code (IaC) configurations, including Terraform, Kubernetes, and CloudFormation, for security misconfigurations and compliance violations.

### **Why Use Checkov?**
✅ **Detects security issues** in Terraform, Kubernetes, CloudFormation, and more.
✅ **Enforces compliance standards** (CIS, NIST, SOC2, PCI-DSS, etc.).
✅ **Works in CI/CD pipelines** to prevent misconfigurations before deployment.
✅ **Supports multiple cloud providers** (AWS, Azure, GCP).

---

## **2. Installing and Running Checkov**

### **Installing Checkov**
Checkov is installed using `pip`:
```bash
pip install checkov
```

### **Running Checkov on a Terraform Directory**
```bash
checkov -d .
```

### **Example Output**
```bash
Checkov scan results:
Passed checks: 24, Failed checks: 2

details:
FAILED CKV_AWS_20: Ensure S3 bucket has logging enabled
FAILED CKV_AWS_21: Ensure S3 bucket has encryption enabled
```

---

## **3. Checkov Rules and Compliance Standards**
Checkov includes built-in security and compliance checks:

| Compliance Standard | Description |
|---------------------|-------------|
| **CIS Benchmarks**  | Security best practices for AWS, Azure, and GCP. |
| **NIST 800-53**     | U.S. government security framework. |
| **SOC 2**           | Security, availability, processing integrity. |
| **PCI-DSS**         | Payment Card Industry Data Security Standard. |

### **Running Checkov with a Specific Framework**
```bash
checkov -d . --framework terraform --check CKV_AWS_20
```

---

## **4. Integrating Checkov with CI/CD Pipelines**

### **GitHub Actions Example:**
```yaml
jobs:
  security_scan:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v2
      - name: Run Checkov scan
        uses: bridgecrewio/checkov-action@v12
        with:
          directory: .
```

### **GitLab CI/CD Example:**
```yaml
checkov:
  stage: security
  image: bridgecrew/checkov
  script:
    - checkov -d .
```

### **Jenkins Pipeline Example:**
```groovy
pipeline {
    agent any
    stages {
        stage('Security Scan') {
            steps {
                sh 'checkov -d .'
            }
        }
    }
}
```

---
