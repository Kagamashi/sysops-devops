## Vendoring in Go Modules
Vendoring is the practice of storing dependencies inside the project directory instead of relying on the external Go module cache.

### When to Use Vendoring
- **Offline Builds**: Ensures all dependencies are available without internet access.
- **Reproducible Builds**: Avoids dependency changes over time.
- **Enterprise Environments**: Some companies require all dependencies to be stored locally for security.

### How to Enable Vendoring
Download dependencies:
```sh
go mod vendor
```
This creates a `vendor/` directory containing all dependencies.

Build using vendored dependencies:
```sh
go build -mod=vendor
```

### Vendoring vs Go Module Cache
| Feature | Vendoring (`vendor/`) | Module Proxy (`GOPATH/pkg/mod`) |
|---------|----------------------|--------------------------------|
| **Storage** | Inside project (`vendor/`) | Global cache (`GOPATH/pkg/mod`) |
| **Use Case** | Required for offline builds, enterprise security | Default behavior for Go Modules |
| **Performance** | Faster for repeated builds | Slower on first download |
