# OpenTelemetry Sampling Policies

## **1. What is Sampling in OpenTelemetry?**
Sampling is a mechanism in OpenTelemetry that **controls the amount of trace data collected**. It helps reduce **overhead and storage costs** while maintaining meaningful observability.

### **Why Use Sampling?**
- Limits **telemetry data volume** in high-traffic environments.
- Reduces **resource usage** and exporter costs.
- Focuses on **important traces** rather than collecting everything.

---

## **2. Types of Sampling Policies**
OpenTelemetry supports different **sampling strategies**:

### **1. Always-On Sampling (Record All Traces)**
- Captures **100% of traces**.
- Useful for **debugging and low-traffic services**.
- **High cost** for large-scale production workloads.

**Example Configuration:**
```sh
export OTEL_TRACES_SAMPLER=always_on
```

### **2. Always-Off Sampling (Drop All Traces)**
- Completely **disables tracing**.
- Used for services that do not require observability.

**Example Configuration:**
```sh
export OTEL_TRACES_SAMPLER=always_off
```

### **3. Probability Sampling (Trace Percentage Based)**
- Collects a **random subset** of traces.
- **Reduces overhead** while preserving statistical accuracy.
- Sampling rate is defined as a **fraction** (e.g., `0.1` = 10% of traces collected).

**Example Configuration:**
```sh
export OTEL_TRACES_SAMPLER=traceidratio
export OTEL_TRACES_SAMPLER_ARG=0.1  # 10% of traces sampled
```

### **4. Parent-Based Sampling**
- Follows the parent span's sampling decision.
- Ensures consistency across **distributed traces**.

**Example Configuration:**
```sh
export OTEL_TRACES_SAMPLER=parent_based
```

---

## **3. Adjusting Sampling Rates in Production**

### **Best Practices for Dynamic Sampling in Production**
- **Use Probability Sampling** (`traceidratio`) to balance observability and cost.
- **Increase sampling for critical paths** (e.g., errors, slow queries).
- **Use Adaptive Sampling** (e.g., dynamic sampling rates based on traffic volume).
- **Configure per-environment sampling**:
  - `always_on` for **development**
  - `traceidratio=0.1` for **staging**
  - `traceidratio=0.01` for **high-traffic production**

### **Dynamically Adjusting Sampling via OpenTelemetry Collector**
Sampling can be adjusted in **OpenTelemetry Collector** to fine-tune trace collection dynamically.

#### **Example: Dynamic Sampling in OpenTelemetry Collector**
```yaml
processors:
  tail_sampling:
    policies:
      - name: error-traces
        type: status_code
        status_code:
          status: ERROR
          sampling_percentage: 100
      - name: low-traffic
        type: traceidratio
        traceidratio:
          sampling_percentage: 10
```

---

## **4. Choosing the Right Sampling Strategy**
| Scenario | Recommended Sampling Strategy |
|----------|-----------------------------|
| Local Development | `always_on` |
| Low-Traffic Service | `always_on` |
| High-Traffic Production | `traceidratio=0.01` (1%) |
| Critical Transactions (e.g., payments) | `always_on` or high sampling rate |
| Debugging Issues | Increase `traceidratio` temporarily |

By **choosing the right sampling policy**, teams can **optimize trace collection**, reduce **storage costs**, and ensure **effective observability** in OpenTelemetry.
