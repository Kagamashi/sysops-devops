# 🔹 Microservices Patterns

Microservices are small, independent services that communicate over the network. Below are common patterns used in microservices architecture:

| Pattern                  | Description                                                   |
|--------------------------|---------------------------------------------------------------|
| **API Gateway**          | Routes requests to appropriate services, adds security and logging. |
| **Circuit Breaker**      | Prevents cascading failures when a service is down.          |
| **Service Discovery**    | Dynamically locates microservices (e.g., Consul, Eureka).    |
| **Event-Driven Architecture** | Services communicate via async events (e.g., Kafka, NATS). |
| **Strangler Pattern**    | Gradually replaces a monolithic system with microservices.   |

---

## 📌 Example: Using an API Gateway

```go
package main

import (
    "fmt"
    "net/http"
)

func userService(w http.ResponseWriter, r *http.Request) {
    fmt.Fprintln(w, "User Service: User Data")
}

func main() {
    http.HandleFunc("/user", userService)
    fmt.Println("API Gateway running on port 8080")
    http.ListenAndServe(":8080", nil)
}
```

✅ **Encapsulates backend services**  
✅ **Simplifies authentication & load balancing**  

---

# 🔹 The 12-Factor App Principles

The **12-Factor Methodology** improves microservice deployment & scaling.

| Factor               | Description |
|----------------------|-------------|
| **Codebase**        | One repo per microservice, multiple deployments. |
| **Dependencies**    | Explicitly declare dependencies (e.g., `go.mod`). |
| **Config**         | Store config in environment variables, not in code. |
| **Backing Services** | Treat databases & external APIs as attached resources. |
| **Build, Release, Run** | Separate build, release, and execution stages. |
| **Processes**       | Stateless services, store session data externally. |
| **Port Binding**    | Services expose HTTP ports for communication. |
| **Concurrency**     | Scale by running multiple instances. |
| **Disposability**   | Services start & stop quickly. |
| **Dev/Prod Parity** | Keep development & production environments similar. |
| **Logs**           | Output structured logs to standard output. |
| **Admin Processes** | Run one-off admin tasks separately. |

---

## 📌 Example: Storing Config in Environment Variables

```go
package main

import (
    "fmt"
    "os"
)

func main() {
    dbURL := os.Getenv("DATABASE_URL")
    fmt.Println("Database URL:", dbURL)
}
```

✅ **Avoids hardcoding secrets in the code**  
✅ **Improves security & scalability**
