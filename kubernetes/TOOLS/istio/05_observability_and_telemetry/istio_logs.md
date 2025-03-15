**# Logs and Access Logs in Istio**

## **Envoy Sidecar Logs**
Istio uses **Envoy** as a sidecar proxy to handle service-to-service communication. Each Envoy proxy generates logs, which include access logs and general operational logs.

### **Viewing Envoy Sidecar Logs**
To check logs for a specific **Envoy sidecar**:
```sh
kubectl logs -l app=my-service -c istio-proxy -n default
```

To stream logs in real-time:
```sh
kubectl logs -l app=my-service -c istio-proxy -n default -f
```

## **Adjusting Envoy Log Levels**
Istio allows changing the **log verbosity** of Envoy proxies dynamically for debugging purposes.

### **Changing Log Levels Temporarily**
Run the following command to set the **debug log level** for a specific pod:
```sh
kubectl exec -it my-pod -c istio-proxy -n default -- curl -X POST "http://localhost:15000/logging?level=debug"
```

Other available log levels: `trace`, `debug`, `info`, `warning`, `error`, `critical`, `off`

### **Persisting Log Level Changes**
Modify the Istio **ProxyConfig** resource:
```yaml
apiVersion: install.istio.io/v1alpha1
kind: IstioOperator
metadata:
  name: istio-control-plane
  namespace: istio-system
spec:
  meshConfig:
    defaultConfig:
      proxyMetadata:
        ISTIO_LOG_LEVEL: "debug"
```
Apply the configuration:
```sh
kubectl apply -f istio-config.yaml
```

## **Aggregating Logs in EFK or Splunk**
For centralized log collection and analysis, Istio logs can be sent to **Elasticsearch, Fluentd, Kibana (EFK)** or **Splunk**.

### **Using Fluentd for Log Collection**
1. **Deploy Fluentd** in your cluster:
   ```sh
   kubectl apply -f https://raw.githubusercontent.com/fluent/fluentd-kubernetes-daemonset/master/fluentd-daemonset-elasticsearch-rbac.yaml
   ```
2. **Configure Fluentd to collect Istio logs** by adding the following to `fluentd.conf`:
   ```yaml
   <filter kubernetes.**>
     @type parser
     format json
     key_name log
   </filter>
   ```
3. **View logs in Kibana** by port-forwarding Elasticsearch:
   ```sh
   kubectl port-forward svc/elasticsearch 9200:9200 -n logging
   ```

### **Sending Logs to Splunk**
1. **Deploy Splunk Connect for Kubernetes**:
   ```sh
   helm install splunk-connect -n logging splunk/splunk-connect-for-kubernetes \
     --set splunk.hec.token=<your-splunk-token> \
     --set splunk.hec.url=https://splunk.example.com:8088
   ```
2. **Verify logs are received in Splunk** by searching `index="kubernetes_logs"`

## **Conclusion**
- **Envoy sidecar logs** provide insights into Istio traffic.
- **Log levels** can be dynamically adjusted for debugging.
- **EFK and Splunk** are effective solutions for **log aggregation and monitoring**.

By integrating Istio logs with centralized log management, teams can improve **observability, debugging, and security monitoring**.

---
