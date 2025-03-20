# Multi-Stage Builds for Go

Multi-stage builds help reduce image size, improve security, and optimize performance by separating the build process from the final runtime image.

## Benefits of Multi-Stage Builds
- **Smaller images**: Remove unnecessary build tools from the final image.
- **Better security**: Reduce the attack surface by using minimal base images.
- **Optimized performance**: Faster startup times with smaller, statically linked binaries.

## Base Images for Go
| **Base Image** | **Size** | **Description** |
|--------------|---------|----------------|
| `golang:1.20` | 1GB+ | Full Go toolchain for building applications |
| `alpine` | ~5MB | Small Linux distro with package manager |
| `scratch` | 0MB | Completely empty base image for static binaries |
| `distroless/static` | ~2MB | Minimal, secure runtime-only image |

---

## Example: Using `scratch` for Minimal Images
If your Go binary is fully statically linked, you can use `scratch`, an empty base image.

```dockerfile
# Build stage
FROM golang:1.20 AS builder

WORKDIR /app
COPY . .
RUN go mod tidy && CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o myapp

# Minimal final image
FROM scratch
COPY --from=builder /app/myapp /myapp
CMD ["/myapp"]
```

✅ **Pros of `scratch`**:
- Zero attack surface (literally no extra files)
- Fastest startup time
- Smallest possible image (only contains the binary)

❌ **Cons of `scratch`**:
- No shell (sh), package manager, or debugging tools
- Harder to debug inside the container

---

## Example: Using `distroless/static`
For minimal dependencies with networking and timezone support, use `distroless/static`.

```dockerfile
# Build stage
FROM golang:1.20 AS builder

WORKDIR /app
COPY . .
RUN go mod tidy && CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o myapp

# More secure than `scratch`, but still minimal
FROM gcr.io/distroless/static
COPY --from=builder /app/myapp /myapp
CMD ["/myapp"]
```

✅ **Pros of `distroless/static`**:
- Almost as small as `scratch`, but supports networking and DNS.
- Better security (no package manager or unnecessary utilities).

---

## Best Practices for Containerizing Go Apps

### 🔹 Use Multi-Stage Builds
- Keeps final images small.
- Removes unnecessary tools from production images.

### 🔹 Set `CGO_ENABLED=0` for Static Binaries
- Ensures pure Go binaries that run in `scratch` or `distroless`.

### 🔹 Use Minimal Base Images (`scratch` or `distroless`)
- Reduces vulnerabilities.
- Improves startup time.

### 🔹 Reduce Binary Size (Optional)
```sh
go build -ldflags="-s -w" -o myapp
```
- `-s`: Remove symbol table.
- `-w`: Remove debugging information.

### 🔹 Enable Garbage Collection for Better Memory Usage
```sh
GODEBUG=madvdontneed=1
```
- Helps with memory reclamation in long-running services.

### 🔹 Use `COPY` Instead of `ADD` in Dockerfile
- `COPY` is faster and more secure.
- `ADD` should only be used for extracting `.tar` files.

### 🔹 Use Healthchecks
```dockerfile
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s \
  CMD curl -f http://localhost:8080/health || exit 1
```
- Ensures containers are restarted if they fail.

### 🔹 Optimize Layers to Improve Build Caching
```dockerfile
COPY go.mod go.sum .
RUN go mod download
COPY . .
```
- This allows Docker to cache dependencies efficiently.
