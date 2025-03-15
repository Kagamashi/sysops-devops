# Custom Scalers and Extensions in KEDA

## Creating or Using Community Scalers
While KEDA provides many built-in scalers, custom scalers can be created to support additional event sources. These scalers can be developed independently or sourced from the KEDA community.

### **Using Community Scalers**
- Community-contributed scalers may be available outside the official KEDA repository.
- These can be found in the **KEDA Community Catalog** or third-party GitHub repositories.
- Ensure security and compatibility before deploying an unofficial scaler.

#### **Installation Example**
1. Identify a community scaler (e.g., MySQL scaler).
2. Apply the necessary YAML manifests.
```sh
kubectl apply -f https://raw.githubusercontent.com/community-repo/custom-mysql-scaler/main/mysql-scaler.yaml
```

---

## Creating a Custom Scaler
Custom scalers allow extending KEDA to integrate with new event sources.

### **Steps to Create a Custom Scaler**
1. **Develop a gRPC-based scaler**
   - KEDA uses **gRPC Scalers** for external event-driven scaling.
   - Implement a gRPC server that exposes the required APIs.

2. **Define Scaler Metadata**
   - Custom scalers must follow the KEDA scaler contract, implementing:
     - `IsActive` – Determines if scaling is required.
     - `GetMetricSpec` – Defines the metrics exposed.
     - `GetMetrics` – Retrieves the metric values.

3. **Deploy the Scaler as a Service**
   - Package the scaler as a container image.
   - Deploy it in Kubernetes as a service.

4. **Create a `ScaledObject` to Use the Scaler**
   - Reference the new scaler in a `ScaledObject`.
   
#### **Example Custom Scaler Deployment**
```yaml
apiVersion: keda.sh/v1alpha1
kind: ScaledObject
metadata:
  name: custom-grpc-scaledobject
spec:
  scaleTargetRef:
    name: my-app
  minReplicaCount: 1
  maxReplicaCount: 10
  triggers:
    - type: external
      metadata:
        scalerAddress: custom-scaler-service.default.svc.cluster.local:50051
        queueLength: '5'
```

---

## Resource References for Extending KEDA
For more details, refer to the following resources:
- **KEDA gRPC Scaler Guide:** [https://keda.sh/docs/scalers/external-scalers/](https://keda.sh/docs/scalers/external-scalers/)
- **Custom Scaler Examples:** [https://github.com/kedacore/sample-custom-scaler](https://github.com/kedacore/sample-custom-scaler)
- **KEDA Community Scalers:** [https://github.com/kedacore](https://github.com/kedacore)

Custom scalers enable seamless event-driven autoscaling beyond the built-in KEDA integrations, making it possible to scale workloads based on unique event sources and business logic.

