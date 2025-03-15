Routing in Istio
Routing in Istio is defined using VirtualService resources. It allows precise control over how traffic is directed to different services based on request attributes like:

Path-based routing (e.g., /api/v1 vs. /api/v2)
Header-based routing (e.g., users from "test-group" get different responses)
Weight-based routing (e.g., 90% to v1, 10% to v2 for canary deployment)

---

Subsets in Istio
Subsets are defined in DestinationRule resources. They allow traffic to be divided among different versions of a service (e.g., v1, v2). These versions are selected using labels from Kubernetes services.

---

Traffic Splitting in Istio
Traffic splitting is used to gradually shift traffic between different subsets (e.g., during a canary deployment). It distributes requests by percentage between different versions.

---
