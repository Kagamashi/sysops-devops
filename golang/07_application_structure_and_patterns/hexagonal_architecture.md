# Hexagonal Architecture in Go (Ports & Adapters)

Hexagonal Architecture separates business logic from external systems (databases, APIs, UIs) using interfaces.

## Key Benefits:
✅ **Loosely Coupled** – Business logic does not depend on external details.
✅ **Easily Testable** – Can mock external dependencies.
✅ **Flexible** – Switch databases, APIs, or frameworks without affecting business logic.

---

## 🛠️ Structure

- **Domain Layer** – Core Business Logic
- **Application Layer** – Use Cases & Services
- **Infrastructure Layer** – Database, APIs, External Services
- **Adapters** – Interfaces for External Communication

---

## 📌 Folder Structure
```plaintext
project/
│── cmd/                  # Entry points (main.go)
│── internal/             # Business logic (not exposed)
│   ├── domain/           # Domain models & business rules
│   ├── application/      # Use cases / business logic
│   ├── infrastructure/   # DB, external APIs
│   ├── adapters/         # Ports for external communication
│── pkg/                  # Reusable utilities
│── main.go               # Application entry point
```

---

## 🔹 Domain Layer (Core Business Logic)
```go
package domain

type Order struct {
    ID       string
    Customer string
    Items    []string
    Total    float64
}

type OrderRepository interface {
    Save(order *Order) error
    FindByID(id string) (*Order, error)
}
```
✅ **Entities**: `Order`
✅ **Repository Interface**: `OrderRepository` (decouples DB implementation)

---

## 🔹 Application Layer (Use Case Logic)
```go
package application

import "project/internal/domain"

type OrderService struct {
    repo domain.OrderRepository
}

func NewOrderService(repo domain.OrderRepository) *OrderService {
    return &OrderService{repo: repo}
}

func (s *OrderService) CreateOrder(order *domain.Order) error {
    // Business rules
    if len(order.Items) == 0 {
        return fmt.Errorf("order must have at least one item")
    }
    return s.repo.Save(order)
}
```
✅ **Business Logic inside `OrderService`**
✅ **Uses Repository Interface (no database dependency)**

---

## 🔹 Infrastructure Layer (Database Implementation)
```go
package infrastructure

import (
    "project/internal/domain"
    "errors"
)

type InMemoryOrderRepository struct {
    orders map[string]*domain.Order
}

func NewInMemoryOrderRepository() *InMemoryOrderRepository {
    return &InMemoryOrderRepository{orders: make(map[string]*domain.Order)}
}

func (r *InMemoryOrderRepository) Save(order *domain.Order) error {
    r.orders[order.ID] = order
    return nil
}

func (r *InMemoryOrderRepository) FindByID(id string) (*domain.Order, error) {
    order, exists := r.orders[id]
    if !exists {
        return nil, errors.New("order not found")
    }
    return order, nil
}
```
✅ **Implements `OrderRepository`**
✅ **Can be replaced with a real database later**

---

## 🔹 API Layer (Adapter)
```go
package adapters

import (
    "encoding/json"
    "net/http"
    "project/internal/application"
    "project/internal/domain"
)

type OrderHandler struct {
    service *application.OrderService
}

func NewOrderHandler(service *application.OrderService) *OrderHandler {
    return &OrderHandler{service: service}
}

func (h *OrderHandler) CreateOrderHandler(w http.ResponseWriter, r *http.Request) {
    var order domain.Order
    if err := json.NewDecoder(r.Body).Decode(&order); err != nil {
        http.Error(w, "invalid request", http.StatusBadRequest)
        return
    }

    if err := h.service.CreateOrder(&order); err != nil {
        http.Error(w, err.Error(), http.StatusBadRequest)
        return
    }

    w.WriteHeader(http.StatusCreated)
}
```
✅ **Decouples business logic from HTTP**
✅ **Can be replaced with gRPC, CLI, or GraphQL**

---

## 🔹 Bringing Everything Together in `main.go`
```go
package main

import (
    "net/http"
    "project/internal/application"
    "project/internal/infrastructure"
    "project/internal/adapters"
)

func main() {
    repo := infrastructure.NewInMemoryOrderRepository()
    service := application.NewOrderService(repo)
    handler := adapters.NewOrderHandler(service)

    http.HandleFunc("/orders", handler.CreateOrderHandler)
    http.ListenAndServe(":8080", nil)
}
```
✅ **Decouples layers using interfaces**
✅ **Easily switch implementations (e.g., DB, API, UI)**

