# Go Modules - Dependency Management in Go

Go modules are the standard way to manage dependencies in Go projects. Since Go 1.14, modules replaced the older GOPATH-based dependency management system.

---

## Initializing a Go Module
To initialize a new Go module, navigate to your project directory and run:
```sh
go mod init [module]
```
This creates a **go.mod** file, which defines the module name and dependencies.

---

## The `go.mod` File
The `go.mod` file keeps track of module dependencies and contains:
- **Module name** (usually the repository URL for shared packages).
- **Go version** used for the project.
- **Dependency requirements** and their versions.

Example `go.mod` file:
```go
module github.com/user/mymodule  // Defines module name

go 1.20  // Specifies Go version

require (
    github.com/sirupsen/logrus v1.8.1
    github.com/stretchr/testify v1.7.0
)
```

---

## The `go.sum` File
The `go.sum` file ensures module integrity by recording the cryptographic checksums of dependencies.

Example `go.sum` file:
```sh
github.com/sirupsen/logrus v1.8.1 h1:Mq9P1gWEt1ePChs...
github.com/sirupsen/logrus v1.8.1/go.mod h1:7C46...
```

### Why is `go.sum` important?
- Ensures consistent dependency versions across machines.
- Prevents supply chain attacks by verifying module authenticity.

---

## Versioning in Go Modules
Go modules follow Semantic Versioning (`MAJOR.MINOR.PATCH`):
```
v1.2.3  →  Major (breaking changes).Minor (new features).Patch (bug fixes)
```

### Installing and Updating Dependencies

**Install the latest version:**
```sh
go get github.com/sirupsen/logrus
```

**Install a specific version:**
```sh
go get github.com/sirupsen/logrus@v1.8.1
```

**Upgrade to the latest minor/patch version:**
```sh
go get -u github.com/sirupsen/logrus@v1.8.1
```

**Upgrade to the latest major version (May break compatibility):**
```sh
go get -u=github.com/sirupsen/logrus@latest
```

**Upgrade all dependencies to their latest versions:**
```sh
go get -u ./...
```

**Upgrade only minor/patch versions:**
```sh
go get -u=patch ./...
```

---

## Cleaning Up Unused Dependencies
To remove unused dependencies and ensure `go.mod` is tidy:
```sh
go mod tidy
```
**What it does?**
- Removes unused dependencies.
- Adds missing dependencies if required.

---

## Module Proxy
Module proxy is a caching layer that serves Go modules efficiently.
Instead of downloading dependencies from GitHub every time, Go retrieves them from module proxy
```sh
export GOPROXY=https://proxy.golang.org
```

### Disabling the Proxy
If we want to download dependencies directly from GitHub:
'''sh
export GOPROXY=direct
'''

### Using a Custom Proxy
'''sh
export GOPROXY=https://mycompany.proxy.com
'''
Useful for:
- Private modules (internal company packages)
- Better caching and speed

---
