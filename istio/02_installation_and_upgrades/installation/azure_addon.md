# Installing Istio Add-On in Azure

## Difference Between Add-On and Open-Source Istio
- **Compatibility:**
  - Istio versions are tested and verified to be compatible with supported AKS versions.
- **Managed Control Plane:**
  - Microsoft handles scaling, configuration, and lifecycle management (upgrades) of the Istio control plane.
- **Integrated Scaling:**
  - AKS components like CoreDNS are automatically scaled when Istio is enabled.
- **Ingress:**
  - Verified external and internal ingress setups.
- **Monitoring:**
  - Compatible with Azure Monitor, Azure Managed Grafana, and Prometheus.
- **Support:**
  - Official Azure support is provided for the add-on.

### Limitations
- The add-on is incompatible with:
  - AKS clusters using the Open Service Mesh add-on.
  - AKS clusters with Istio already installed outside the add-on.
- **Windows Server Containers:**
  - Not supported.
- **Customization Restrictions:**
  - Custom resources like `EnvoyFilter`, `ProxyConfig`, `WorkloadEntry`, `Telemetry`, and `IstioOperator` are currently blocked.

---

## Deploying the Istio-Based Service Mesh Add-On (Preview)

### Step 1: Enable Required Features and Extensions
1. Add and update the `aks-preview` extension:
   ```bash
   az extension add --name aks-preview
   az extension update --name aks-preview
   ```
2. Register the Azure Service Mesh preview feature:
   ```bash
   az feature register --namespace "Microsoft.ContainerService" --name "AzureServiceMeshPreview"
   az feature show --namespace "Microsoft.ContainerService" --name "AzureServiceMeshPreview"
   ```
3. Register the provider:
   ```bash
   az provider register --namespace Microsoft.ContainerService
   ```

---

### Step 2: Install the Istio Add-On

#### Option 1: At Cluster Creation
- Enable Istio add-on during AKS cluster creation:
  ```bash
  az aks create ... --enable-asm
  ```

#### Option 2: For Existing Clusters
- Enable Istio add-on for an existing AKS cluster:
  ```bash
  az aks mesh enable --resource-group ${RESOURCE_GROUP} --name ${CLUSTER}
  ```
- Verify the add-on installation:
  ```bash
  az aks show --resource-group ${RESOURCE_GROUP} --name ${CLUSTER} --query 'serviceMeshProfile.mode'
  ```

---

### Step 3: Enable Sidecar Injection
- Label namespaces to enable automatic sidecar injection:
  ```bash
  kubectl label namespace default istio.io/rev=asm-1-17
  ```
- Alternatively, manually inject the sidecar:
  ```bash
  kubectl apply -f <(istioctl kube-inject -f sample.yaml -i aks-istio-system -r asm-1-17) -n foo
  ```
