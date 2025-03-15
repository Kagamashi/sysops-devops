# Kubernetes Events and Debugging with kubectl

## **Checking Events in Kubernetes**
Kubernetes **events** provide insights into cluster activity, failures, and troubleshooting hints. Events include information about **Pod scheduling, container failures, node issues, and networking problems**.

### **Viewing Events with kubectl**

#### **1. Checking Events for a Specific Pod**
```bash
kubectl describe pod <pod-name> -n <namespace>
```
This command shows detailed information, including **events** related to the Pod.

#### **2. Listing All Events in a Namespace**
```bash
kubectl get events -n <namespace>
```
This command retrieves all recent events in the specified namespace.

#### **3. Filtering Events by Type (Warnings or Normal)**
```bash
kubectl get events --field-selector type=Warning -n <namespace>
```
This filters out only **warnings**, helping to identify failed Pods, scheduling issues, or node problems.

#### **4. Sorting Events by Timestamp**
```bash
kubectl get events --sort-by='.metadata.creationTimestamp' -n <namespace>
```
This shows events in chronological order, making it easier to diagnose recent issues.

---

## **Using kubectl debug for Troubleshooting**
Kubernetes **kubectl debug** is used for advanced troubleshooting by running **ephemeral containers** inside a failing Pod.

### **1. Debugging a Running Pod**
If a container is running but experiencing issues, you can attach a debugging container.

```bash
kubectl debug pod/<pod-name> -it --image=busybox --target=<container-name> -n <namespace>
```
- **`--target=<container-name>`**: Specifies the container to debug.
- **`--image=busybox`**: Runs a temporary **BusyBox** container.

### **2. Creating a Debug Pod for a Node**
When troubleshooting a **node**, you can create a debug Pod with a privileged container.

```bash
kubectl debug node/<node-name> -it --image=busybox -- bash
```
This allows inspecting system logs, network issues, and disk space problems on a node.

### **3. Debugging a Pod That Fails to Start**
If a Pod is **crash-looping** or **not starting**, you can create an ephemeral container.

```bash
kubectl debug pod/<pod-name> -it --image=busybox --share-processes
```
- **`--share-processes`**: Shares the process namespace, allowing inspection of other containers.

### **4. Running a Shell in a Running Container**
```bash
kubectl exec -it <pod-name> -- /bin/sh
```
This is useful when a Pod is running but behaving unexpectedly.

### **5. Checking Logs for Debugging**
```bash
kubectl logs <pod-name> -n <namespace>
```
Use `-f` to stream logs in real-time:
```bash
kubectl logs -f <pod-name> -n <namespace>
```

---

## **Best Practices for Debugging Kubernetes Issues**

| Debugging Action | When to Use |
|-----------------|-------------|
| **kubectl describe pod** | Check Pod status, reason for failure. |
| **kubectl get events** | View recent issues like scheduling delays. |
| **kubectl logs** | Inspect application logs for errors. |
| **kubectl exec** | Manually test inside a running container. |
| **kubectl debug** | Add an ephemeral container to troubleshoot failures. |
| **kubectl debug node** | Inspect node-level issues like disk or networking. |

By leveraging **kubectl debug, logs, and events**, Kubernetes users can efficiently **diagnose and resolve** issues within Pods, Nodes, and workloads.
