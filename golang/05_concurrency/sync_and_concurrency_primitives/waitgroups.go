package main
import (
	"fmt"
	"sync"
	"time"
)

/*
sync.WaitGroup is used to wait for multiple goroutines to complete.
- Creating a WaitGroup:
1. Declare sync.WaitGroup variable
2. Use wg.Add(n) to specify the number of goroutines to wait for
3. Each goroutine calls wg.Done() when finished
4. Main goroutine calls wg.Wait() to block until all tasks are complete

	var wg sync.WaitGroup
	for i := 1; i <= 3; i++ {
		wg.Add(1)
		go func(i int) {
			defer wg.Done()
			// Task execution
		}(i)
	}
	wg.Wait()  // Wait for all goroutines to finish

- Simplifies synchronization and ensures all goroutines complete before proceeding
- NOTE: This approach doesn't have straightforward way to propagate errors from workers:
https://pkg.go.dev/golang.org/x/sync/errgroup
*/

func worker_wg(id int) { // function to run in each goroutine
	fmt.Printf("Worker %d starting\n", id)
	time.Sleep(time.Second) // simulate a time-consuming task
	fmt.Printf("Worker %d done\n", id)
}

func waitgroups() {

	var wg sync.WaitGroup // WaitGroup used to ensure all launched goroutines complete
	// NOTE: if passing WaitGroup into functions, it should be done by pointer

	for i := 1; i <= 5; i++ { // launch multiple goroutines and increment the WaitGroup counter for each one
		wg.Add(1)

		go func() { // wrap the worker call in a closure to ensure the WaitGroup is notified when the worker completes
			defer wg.Done() // ensures the WaitGroup is decremented when the worker finishes, without requiring the worker to manage concurrency directly
			worker_wg(i)
		}()
	}

	wg.Wait() // wait until the WaitGroup counter returns to 0, indicating all workers have completed
	/*
		Worker 5 starting
		Worker 3 starting
		Worker 4 starting
		Worker 1 starting
		Worker 2 starting
		Worker 4 done
		Worker 1 done
		Worker 2 done
		Worker 5 done
		Worker 3 done
	*/

}
