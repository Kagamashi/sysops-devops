
# Stage 1: Build the Go Binary
FROM golang:1.21 AS builder

# Set the working directory inside the container
WORKDIR /app

# Copy go mod and sum files for dependency resolution
COPY go.mod go.sum ./

# Download dependencies only (for better caching)
RUN go mod download

# Copy the source code into the container
COPY . .

# Build the Go binary
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o app ./main.go


# Stage 2: Create a minimal final image
# Use a minimal base image (scratch, distroless, or alpine)
FROM gcr.io/distroless/static:nonroot

# Set the working directory inside the container
WORKDIR /root/

# Copy the compiled binary from the builder stage
COPY --from=builder /app/app .

# Use a non-root user for security best practices
USER nonroot:nonroot

# Define the entrypoint to run the app
ENTRYPOINT ["./app"]
