
## Multiple Triggers and Conditions

### **Combining Triggers: Logical OR vs. Logical AND**
- **Logical OR (default behavior)**: If any trigger meets its threshold, scaling occurs.
- **Logical AND (all triggers must meet thresholds)**: Requires `activationMode: and` in `ScaledObject`.

#### **Example: Logical OR (default scaling)**
```yaml
triggers:
  - type: kafka
    metadata:
      topic: my-topic
      consumerGroup: my-group
  - type: prometheus
    metadata:
      serverAddress: http://prometheus-server:9090
      metricName: http_requests_total
      threshold: "100"
```
(Scaling occurs if either Kafka or Prometheus triggers fire.)

#### **Example: Logical AND (all conditions must be met)**
```yaml
apiVersion: keda.sh/v1alpha1
kind: ScaledObject
metadata:
  name: my-scaledobject
spec:
  scaleTargetRef:
    name: my-deployment
  activationMode: and  # All triggers must be met
  triggers:
    - type: rabbitmq
      metadata:
        queueName: my-queue
    - type: cpu
      metadata:
        type: Utilization
        value: "80"
```
(Scaling occurs only if both RabbitMQ queue messages and CPU utilization thresholds are exceeded.)

### **Edge Cases: Competing Triggers and Priority in Scaling**
- **Conflicting triggers**: If one trigger suggests scaling down while another suggests scaling up, KEDA maintains the highest required replica count.
- **Multiple triggers for the same workload**: Each trigger contributes independently to the final scaling decision.
- **Scaling spikes**: Proper cooldown periods prevent frequent scaling fluctuations.

---
