package main
import (
	"testing"
)

/*
testing package includes B for benchmarking (performance) functions
- 'go test -bench=.' to run all benchmarks in a package
- 'go test -bemch=. -benchmem' to track allocations and memory usage
- Benchmark functions must start with Benchmark and accept a *testing.B parameter

Example output:
BenchmarkSum-8    12345678    100 ns/op    0 B/op    0 allocs/op
		BenchmarkSum-8 → Ran with 8 CPU threads.
		12345678 → Number of iterations.
		100 ns/op → Each iteration took 100 nanoseconds.
		0 B/op → No heap allocations (good for performance).
		0 allocs/op → No extra memory allocations.

Common functions:
	b.ResetTimer() 	  resets the timer so that only the code after this point is benchmarked
	b.StopTimer() and b.StartTimer()	  pause and resume timing during the benchmark
	b.N		 the number of iterations the benchmark will run, used to control the loop
*/

// Function to benchmark
func Sum(n int) int {
	sum := 0
	for i := 0; i < n; i++ {
		sum += i
	}
	return sum
}

// Benchmark function (must start with `Benchmark`)
func BenchmarkSum(b *testing.B) {
	for i := 0; i < b.N; i++ {
		Sum(1000) // Run multiple times to measure performance
	}
}