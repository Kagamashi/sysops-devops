package main
import (
	"fmt"
	"math/rand"
	"sync"
	"time"
)

/*
Fan-Out occurs when multiple goroutines read from the same input channel and process jobs concurrently
- distributes work among multiple worker_io goroutines

Fan-In when multiple channels send their results into a single channel
- merges results from multiple channels into one

Ensures parallelism and efficiency
*/

// Worker_io function for Fan-Out
func worker_io(id int, jobs <-chan int, results chan<- int, wg *sync.WaitGroup) {
	defer wg.Done()
	for job := range jobs {
		time.Sleep(time.Millisecond * time.Duration(rand.Intn(500))) // Simulating work
		results <- job * 2
		fmt.Printf("Worker_io %d processed job %d\n", id, job)
	}
}

// Fan-In function collects results from multiple sources
func fanIn(channels ...<-chan int) <-chan int {
	out := make(chan int)
	var wg sync.WaitGroup

	// Merge results from all channels
	for _, ch := range channels {
		wg.Add(1)
		go func(c <-chan int) {
			defer wg.Done()
			for val := range c {
				out <- val
			}
		}(ch)
	}

	// Close output channel when all sources finish
	go func() {
		wg.Wait()
		close(out)
	}()
	return out
}

func fanInOut() {
	numWorker_ios := 3
	numJobs := 10

	jobs := make(chan int, numJobs)
	results := make(chan int, numJobs)
	var wg sync.WaitGroup

	// Fan-Out: Start multiple worker_io goroutines
	for i := 1; i <= numWorker_ios; i++ {
		wg.Add(1)
		go worker_io(i, jobs, results, &wg)
	}

	// Send jobs
	for j := 1; j <= numJobs; j++ {
		jobs <- j
	}
	close(jobs)

	// Close results channel after all worker_ios are done
	go func() {
		wg.Wait()
		close(results)
	}()

	// Fan-In: Collect results into a single channel
	mergedResults := fanIn(results)

	// Print final results
	for result := range mergedResults {
		fmt.Println("Final Result:", result)
	}
}
