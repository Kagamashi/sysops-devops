# Terratest: Infrastructure Testing for Terraform

## **1. What is Terratest?**
Terratest is a **Go-based testing framework** for validating infrastructure code such as Terraform, Kubernetes, and Docker configurations.

### **Why Use Terratest?**
✅ **Automates testing of Terraform configurations**.
✅ **Validates infrastructure deployment before applying changes to production**.
✅ **Supports unit, integration, and end-to-end testing**.
✅ **Works with multiple cloud providers** (AWS, Azure, GCP, etc.).
✅ **Integrates with CI/CD pipelines** for continuous validation.

---

## **2. Installing and Running Terratest**

### **Installing Go (Required for Terratest)**
```bash
# Install Go (Linux/macOS)
wget https://go.dev/dl/go1.19.linux-amd64.tar.gz
tar -C /usr/local -xzf go1.19.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin
```

### **Setting Up a Go Project for Terratest**
```bash
mkdir terratest-example && cd terratest-example
go mod init example.com/terratest-example
go get github.com/gruntwork-io/terratest/modules/terraform
```

---

## **3. Writing a Basic Terraform Test with Terratest**

### **Example: Testing a Terraform Module**
```go
package test

import (
    "testing"
    "github.com/gruntwork-io/terratest/modules/terraform"
    "github.com/stretchr/testify/assert"
)

func TestTerraformBasic(t *testing.T) {
    terraformOptions := &terraform.Options{
        TerraformDir: "../terraform-module",
    }
    defer terraform.Destroy(t, terraformOptions)
    terraform.InitAndApply(t, terraformOptions)

    output := terraform.Output(t, terraformOptions, "instance_id")
    assert.NotEmpty(t, output)
}
```

### **Explanation:**
- Initializes and applies Terraform in a test directory.
- Retrieves an output (`instance_id`) from the Terraform state.
- Uses `assert.NotEmpty` to validate the output.
- Cleans up by destroying infrastructure after the test.

---

## **4. Running Terratest**
```bash
go test -v test/
```

Example output:
```bash
=== RUN   TestTerraformBasic
--- PASS: TestTerraformBasic (30.14s)
PASS
ok   example.com/terratest-example 30.15s
```

---

## **5. Integrating Terratest with CI/CD**

### **GitHub Actions Example**
```yaml
name: Terraform Tests
on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v3
      - name: Setup Go
        uses: actions/setup-go@v3
        with:
          go-version: 1.19
      - name: Run Terratest
        run: go test -v test/
```

### **GitLab CI/CD Example**
```yaml
stages:
  - test

test:
  stage: test
  image: golang:1.19
  script:
    - go test -v test/
```

---
