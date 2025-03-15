# Installing Istio with Terraform

This guide outlines how to install Istio on an Azure Kubernetes Service (AKS) cluster using Terraform.

---

## Step 1: Create an AKS Cluster
- Use Terraform to create an AKS cluster.
- Ensure you have the necessary Azure resources set up, such as a resource group and AKS configuration.

---

## Step 2: Create the Istio Namespace
- Create the `istio-system` namespace for Istio components.

```hcl
resource "kubernetes_namespace" "istio_system" {
  provider = kubernetes.local
  metadata {
    name = "istio-system"
  }
}
```

---

## Step 3: Configure Access to the AKS Cluster
- Set the kubeconfig for accessing the AKS cluster.

```hcl
resource "null_resource" "set-kube-config" {
  triggers = {
    always_run = "${timestamp()}"
  }
  provisioner "local-exec" {
    command = "az aks get-credentials -n ${azurerm_kubernetes_cluster.aks.name} -g ${azurerm_resource_group.rg.name} --file \".kube/${azurerm_kubernetes_cluster.aks.name}\" --admin --overwrite-existing"
  }
  depends_on = [local_file.kube_config]
}
```

---

## Step 4: Create Secrets for Grafana and Kiali (Optional)
- Define Kubernetes secrets for tools like Grafana and Kiali.

### Grafana Secret
```hcl
resource "kubernetes_secret" "grafana" {
  provider = kubernetes.local
  metadata {
    name      = "grafana"
    namespace = "istio-system"
    labels = {
      app = "grafana"
    }
  }
  data = {
    username   = "admin"
    passphrase = random_password.password.result
  }
  type       = "Opaque"
  depends_on = [kubernetes_namespace.istio_system]
}
```

### Kiali Secret
```hcl
resource "kubernetes_secret" "kiali" {
  provider = kubernetes.local
  metadata {
    name      = "kiali"
    namespace = "istio-system"
    labels = {
      app = "kiali"
    }
  }
  data = {
    username   = "admin"
    passphrase = random_password.password.result
  }
  type       = "Opaque"
  depends_on = [kubernetes_namespace.istio_system]
}
```

---

## Step 5: Generate Istio Configuration
- Create an Istio manifest file using Terraform.

```hcl
resource "local_file" "istio-config" {
  content = templatefile("${path.module}/istio-aks.tmpl", {
    enableGrafana = true,
    enableKiali   = true,
    enableTracing = true
  })
  filename = ".istio/istio-aks.yaml"
}
```

---

## Step 6: Install Istio Using `istioctl`
- Apply the generated Istio configuration using `istioctl`.

```hcl
resource "null_resource" "istio" {
  triggers = {
    always_run = "${timestamp()}"
  }
  provisioner "local-exec" {
    command = "istioctl manifest apply -f \".istio/istio-aks.yaml\" --kubeconfig \".kube/${azurerm_kubernetes_cluster.aks.name}\""
  }
  depends_on = [kubernetes_secret.grafana, kubernetes_secret.kiali, local_file.istio-config]
}
```

---

## Step 7: Sample `istio-aks.yaml` File
- Below is an example configuration for the Istio control plane.

```yaml
apiVersion: install.istio.io/v1alpha2
kind: IstioControlPlane
spec:
  profile: default
  values:
    global:
      defaultNodeSelector:
        beta.kubernetes.io/os: linux
      controlPlaneSecurityEnabled: true
      mtls:
        enabled: false
    grafana:
      enabled: ${enableGrafana}
      security:
        enabled: true
    kiali:
      enabled: ${enableKiali}
    tracing:
      enabled: ${enableTracing}
```

---

## Step 8: Apply Terraform and Verify Installation
- Run `terraform apply` to create the AKS cluster, Kubernetes secrets, and install Istio.
- Verify the Istio installation:

```bash
istioctl verify-install -f .istio/istio-aks.yaml
```
