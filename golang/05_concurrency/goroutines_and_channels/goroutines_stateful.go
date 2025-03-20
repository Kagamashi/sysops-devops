package main
import (
	"fmt"
	"math/rand"
	"sync/atomic"
	"time"
)

/*
Stateful goroutine encapsulated state (data) and manages it internally (within a goroutine), allowing safe access without requiring locks or mutexes.
- Instead of directly sharing state, pass messages or tasks to the goroutine via channels, which handles the state internally
func statefulWorker(jobs <-chan int, results chan<- int) {
    var state int
    for job := range jobs {
        state += job
        results <- state
    }
}

jobs := make(chan int, 10)
results := make(chan int, 10)
go statefulWorker(jobs, results)

- By isolating the state within a goroutine it avoids the need for synchronization mechanisms like mutexes, providing a simpler concurrency model.
- Manages counters, session data, or any mutable state safely across multiple requests or tasks.
*/

type readOp struct {
	key  int
	resp chan int
}
type writeOp struct {
	key  int
	val  int
	resp chan bool
}

func stateful_goroutines() {

	var readOps uint64 // Define two atomic counters
	var writeOps uint64

	reads := make(chan readOp) // Create channels to handle read and write requests
	writes := make(chan writeOp)

	// Goroutine to manage the shared state (a map) and handle read/write requests
	go func() {
		var state = make(map[int]int)
		for {
			select {
			case read := <-reads: // Handle read request by retrieving the value for the given key and sending it back on the response channel
				read.resp <- state[read.key]
			case write := <-writes: // Handle a write request by updating the state with the new value and sending confirmation on the response channel
				state[write.key] = write.val
				write.resp <- true
			}
		}
	}()

	// Launch 100 goroutines for performing read operations
	for r := 0; r < 100; r++ {
		go func() {
			for {
				read := readOp{
					key:  rand.Intn(5), // Random key between 0 and 4
					resp: make(chan int)}
				reads <- read                 // Send read operation to reads channel
				<-read.resp                   // Wait for reposnse from state manager goroutine
				atomic.AddUint64(&readOps, 1) // Atomically increment readOps counter
				time.Sleep(time.Millisecond)  // Sleep for 1 millisecond before doing the next read operation
			}
		}()
	}

	// Launch 10 goroutines for performing write operations
	for w := 0; w < 10; w++ {
		go func() {
			for {
				write := writeOp{
					key:  rand.Intn(5),
					val:  rand.Intn(100),
					resp: make(chan bool)}
				writes <- write
				<-write.resp // Wait for confirmation from state manager goroutine
				atomic.AddUint64(&writeOps, 1)
				time.Sleep(time.Millisecond)
			}
		}()
	}

	time.Sleep(time.Second)

	readOpsFinal := atomic.LoadUint64(&readOps) // Load the final number of read/write operations performed
	fmt.Println("readOps:", readOpsFinal)
	// readOps: 71708

	writeOpsFinal := atomic.LoadUint64(&writeOps)
	fmt.Println("writeOps:", writeOpsFinal)
	// writeOps: 7177

}

/* This scenario might be useful more than mutex one is some cases:
where we have other channels involved or when managing multiple mutexes might be error-prone */
