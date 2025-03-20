package main
import (
	"fmt"
	"sync"
)

/*
Mutexes (Mutual Exclusions) are used to safely access shared data across multiple goroutines by allowing only one goroutine (locks) to access a critical section of code at a time.
- Using sync.Mutex provides Lock() and Unlock() methods to control access to shared resources.
	var mu sync.Mutex
	var counter int
	mu.Lock()
	counter++ // Critical section
	mu.Unlock()

- syncRWMutex is a variant that allows multiple goroutines to read but only one to write.
	RLock() and RUnlock()
- Used to protect shared variables, counters, resources from race conditions when accessed by multiple goroutines
- Mutex should not be copied, if struct is passed around it should be done by pointer
*/

type Container struct {
	mu       sync.Mutex     // Mutex to ensure safe access to the 'counters' map from multiple goroutines
	counters map[string]int // Map to store counters with string keys
}

func (c *Container) inc(name string) { // Method to increment a counter by name in a thread-safe way
	c.mu.Lock() //Lock mutex before modifying the 'counters' map to prevent race conditions

	defer c.mu.Unlock() // Ensure the mutex is unlocked after the function completes
	c.counters[name]++  //Increment the counter for specified key
}

func mutexes() {
	c := Container{ // Initialize new Container with two counters "a" and "b"
		counters: map[string]int{"a": 0, "b": 0},
	}

	var wg sync.WaitGroup // Create WaitGroup to wait for all goroutines to finish

	doIncrement := func(name string, n int) { // Helper function incrementing counter 'n' times
		for i := 0; i < n; i++ {
			c.inc(name)
		}
		wg.Done() //Signal that this goroutine is done
	}

	wg.Add(3)                  //Add 3 to WaitGroup, as we are going to launch 3 goroutines
	go doIncrement("a", 10000) //Increment counter 100000 times
	go doIncrement("a", 10000)
	go doIncrement("b", 10000)

	wg.Wait()
	fmt.Println(c.counters)
	// map[a:20000 b:10000]
}
