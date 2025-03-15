# KEDA: Core Concepts and Architecture

## Architecture Overview
KEDA (Kubernetes Event-driven Autoscaling) extends Kubernetes' autoscaling capabilities by enabling event-driven scaling based on external metrics. It provides fine-grained scaling beyond Kubernetes' built-in Horizontal Pod Autoscaler (HPA).

### Key Components
1. **Metrics API**
   - Exposes custom metrics to Kubernetes' HPA.
   - Fetches external metric data from defined scalers.
   
2. **ScaledObject**
   - A custom resource that defines how KEDA scales a deployment.
   - Specifies the target deployment, trigger conditions (event source), and scaling behavior.

3. **ScaledJob**
   - Similar to ScaledObject but used for batch workloads.
   - Creates Kubernetes Jobs dynamically based on external triggers.

4. **Scalers**
   - Plugins that connect to external event sources (e.g., Kafka, Azure Service Bus, Prometheus).
   - Determine when to scale based on metric values.

## KEDA vs. HPA: Where KEDA Fits
- **HPA (Horizontal Pod Autoscaler)**
  - Scales based on resource metrics (CPU, memory) or custom metrics.
  - Requires an external metric server for custom metrics.
  
- **KEDA**
  - Provides event-driven scaling, enabling scaling from external triggers.
  - Can work alongside HPA by exposing external metrics.
  - Scales down to zero when no events are detected (unlike HPA, which keeps at least one replica running).

KEDA enhances Kubernetes autoscaling by integrating with external event sources, making it ideal for workloads that need dynamic and demand-based scaling beyond traditional CPU and memory metrics.

---
