# Overview of Wiz

## What is Wiz?

[Wiz](https://www.wiz.io/) is a **cloud security platform** designed to provide deep visibility, risk assessment, and compliance monitoring for cloud environments. It helps organizations **identify, prioritize, and remediate** security risks across **multi-cloud environments**, including **Azure, AWS, GCP, and Kubernetes**.

## Key Features of Wiz

### 1. **Agentless Cloud Security**
- Unlike traditional security tools, Wiz does not require installing **agents** on workloads.
- Instead, it scans cloud environments using **API integrations**, reducing overhead and performance impact.

### 2. **Deep Cloud Risk Visibility**
- Provides a **holistic view** of cloud environments, analyzing:
  - **Workloads** (VMs, Containers, Kubernetes, Serverless)
  - **Identities & Permissions** (IAM, RBAC, least privilege analysis)
  - **Network Configurations**
  - **Secrets & Sensitive Data** (e.g., exposed credentials, misconfigurations)

### 3. **Security Graph**
- Wiz builds a **security graph** that correlates cloud risks across multiple layers, including **infrastructure, network, identity, and workloads**.
- Helps security teams **prioritize** critical risks based on real-world attack paths.

### 4. **Multi-Cloud & Kubernetes Security**
- Supports **AWS, Azure, GCP, and Kubernetes**, providing **unified security visibility** across different cloud platforms.
- Detects misconfigurations, vulnerabilities, and compliance violations in **cloud-native workloads**.

### 5. **Misconfiguration & Vulnerability Detection**
- Identifies **cloud misconfigurations** such as **publicly exposed storage, weak IAM roles, and open ports**.
- Scans for **known vulnerabilities (CVEs)** in **container images, VMs, and cloud services**.

### 6. **Identity Security & Least Privilege Analysis**
- Helps organizations **enforce least privilege principles** by analyzing **IAM roles, permissions, and policies**.
- Detects **over-privileged accounts** and **excessive permissions** that could be exploited.

### 7. **Compliance & Governance**
- Provides **automated compliance checks** for frameworks like **CIS, NIST, SOC 2, ISO 27001, PCI DSS, and HIPAA**.
- Generates **audit-ready reports** to help teams meet regulatory requirements.

### 8. **CI/CD & DevSecOps Integration**
- Integrates with **CI/CD pipelines**, scanning **Infrastructure-as-Code (IaC)** for security issues before deployment.
- Supports **Terraform, Kubernetes manifests, Helm charts, and other IaC frameworks**.

### 9. **Automated Risk Prioritization**
- Uses **AI-driven risk scoring** to highlight the most **critical threats**.
- Helps teams **prioritize security fixes** based on real-world attack feasibility.

### 10. **API & SIEM Integration**
- Exposes **APIs** for custom integrations.
- Supports integration with **SIEMs (Splunk, Sentinel, Datadog, etc.)**, ticketing tools, and SOAR platforms for **automated remediation**.

## How Wiz Works
1. **Connect Cloud Accounts** – Wiz integrates via **cloud-native APIs** (no agents required).
2. **Scans & Analyzes Risks** – The platform continuously scans for **misconfigurations, vulnerabilities, and threats**.
3. **Builds a Security Graph** – Wiz correlates risk across identity, network, and workloads.
4. **Prioritizes & Remediates** – Security teams get **actionable insights** with remediation recommendations.

## Benefits of Using Wiz
✅ **Agentless security** – No impact on workloads.
✅ **Multi-cloud support** – Works across AWS, Azure, GCP, and Kubernetes.
✅ **Security Graph for deep risk analysis** – Contextual risk prioritization.
✅ **Automated compliance checks** – Simplifies audits and regulatory reporting.
✅ **Integrates with DevOps workflows** – Helps secure cloud infrastructure from code to runtime.
