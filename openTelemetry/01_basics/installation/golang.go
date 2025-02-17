
// go get go.opentelemetry.io/otel

package main
import (
    "go.opentelemetry.io/otel"
    "go.opentelemetry.io/otel/exporters/stdout"
    "go.opentelemetry.io/otel/sdk/trace"
)
func main() {
    exporter, _ := stdout.New(stdout.WithPrettyPrint())
    provider := trace.NewTracerProvider(trace.WithBatcher(exporter))
    otel.SetTracerProvider(provider)
}
