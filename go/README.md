## Golang (Go)

**Go** is a statically typed, compiled programming language designed for **simplicity, efficiency, and concurrency**. It is widely used for **backend services, cloud applications, networking, and automation**.

- **Official Docs**: [https://go.dev/doc/](https://go.dev/doc/)
- **Go API Reference**: [https://pkg.go.dev/std](https://pkg.go.dev/std)
- **Effective Go**: [https://go.dev/doc/effective_go](https://go.dev/doc/effective_go)
- **Go Modules Guide**: [https://go.dev/blog/using-go-modules](https://go.dev/blog/using-go-modules)
- **Go Playground**: [https://go.dev/play/](https://go.dev/play/)

---

### Dictionary (Key Golang Terms)

- **Go Modules (`go.mod`)**: Dependency management system for Go projects.
- **Goroutine**: A lightweight thread for concurrent execution (`go func() {}`).
- **Channel**: A typed conduit for goroutine communication (`ch := make(chan int)`).
- **Struct**: A collection of fields, similar to a class but without methods (`type Person struct { Name string }`).
- **Interface**: A way to define behavior (`type Reader interface { Read([]byte) (int, error) }`).
- **Defer**: Ensures a function call is executed at the end of the surrounding function (`defer fmt.Println("Done")`).
- **Panic & Recover**: Mechanisms for handling unexpected runtime errors.
- **Garbage Collection**: Go has automatic memory management via GC.

---
