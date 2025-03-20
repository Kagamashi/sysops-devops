package main
import (
	"fmt"
	"sync"
)

/*
Go's built-in map is not safe for concurrent access meaning multiple goroutines reading and writing to a map simultaneously can cause race conditions
sync.Map solves this problem

When to use:
- concurrent-safe map access
- read-heavy scenarios

If use case involves frequent writes - sync.Mutex should be more efficient

*/

func sync_maps() {
	var m sync.Map

	// Store key-value pairs
	m.Store("name", "Alice")
	m.Store("age", 25)

	// Load a value
	if val, ok := m.Load("name"); ok {
		fmt.Println("Name:", val)  // Output: Name: Alice
	}

	// Delete a key
	m.Delete("age")

	// Iterate over all key-value pairs
	m.Range(func(key, value interface{}) bool {
		fmt.Println("Key:", key, "Value:", value)
		return true // Continue iteration
	})
}
