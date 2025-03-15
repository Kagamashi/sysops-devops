
https://kured.dev/docs/
https://github.com/kubereboot/kured/releases/

---

# Kured: Kubernetes Reboot Daemon

## **What is Kured?**
Kured (Kubernetes Reboot Daemon) is an open-source tool designed to automate node reboots in a Kubernetes cluster when required, typically after applying OS security updates. It ensures nodes are rebooted safely and in a controlled manner to maintain cluster stability.

## **Key Features**
- **Automated Node Reboots:** Detects when a node requires a reboot (e.g., `/var/run/reboot-required` for Ubuntu).
- **Safe Draining of Nodes:** Cordon and drain nodes before rebooting to ensure workloads are rescheduled properly.
- **Leader Election Mechanism:** Ensures only one node is rebooted at a time to maintain cluster availability.
- **Customizable Reboot Conditions:** Allows fine-grained control over reboot triggers, schedules, and delays.
- **Integration with DaemonSet:** Runs as a DaemonSet to monitor all nodes continuously.

## **How Kured Works**
1. **Monitors Nodes for Reboot Signals**
   - Checks for the presence of a reboot flag file (e.g., `/var/run/reboot-required`).
2. **Initiates a Safe Drain Process**
   - Cordons and drains the node to ensure workload migration.
3. **Performs a Reboot**
   - Reboots the node and ensures it rejoins the cluster.
4. **Repeats the Process as Needed**
   - Continues monitoring nodes to ensure all required reboots are completed.

## **Basic Deployment**
Kured is typically deployed as a DaemonSet in a Kubernetes cluster.

### **Example Helm Installation**
```sh
helm repo add kured https://weaveworks.github.io/kured
helm install kured kured/kured --namespace kube-system
```

### **Example Kured DaemonSet Configuration**
```yaml
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: kured
  namespace: kube-system
spec:
  selector:
    matchLabels:
      name: kured
  template:
    metadata:
      labels:
        name: kured
    spec:
      containers:
      - name: kured
        image: quay.io/weaveworks/kured:latest
        securityContext:
          privileged: true
        volumeMounts:
        - name: run
          mountPath: /var/run
      volumes:
      - name: run
        hostPath:
          path: /var/run
```

## **Use Cases**
- **Automated Security Updates**: Ensures security patches requiring a reboot are applied without manual intervention.
- **Cluster Stability and Uptime**: Prevents disruption by rebooting nodes in a controlled manner.
- **Compliance and Governance**: Ensures nodes stay updated to meet security compliance requirements.

## **Best Practices**
- **Schedule Maintenance Windows**: Configure time windows to control when reboots happen.
- **Exclude Critical Nodes**: Use tolerations and node selectors to avoid rebooting critical components.
- **Monitor and Alert**: Integrate with Prometheus or logging tools to track reboots.

## **Conclusion**
Kured simplifies and automates node reboots in Kubernetes, ensuring that security updates are applied while maintaining cluster stability. By integrating seamlessly into existing workflows, it helps teams manage OS updates efficiently with minimal manual intervention.

---
