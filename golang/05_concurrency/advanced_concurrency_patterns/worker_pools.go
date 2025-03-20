package main
import (
	"fmt"
	"time"
)

/*
Worker Pool is a pattern where multiple worker goroutines process tasks from a shared job queue
	- limit resource usage
	- prevent system overload from excessive goroutines
	- efficiently distribute tasks among multiple workers

	Key informations:
- job queue is a buffered channel where tasks are submitted
- fixed number of workers (goroutines) process jobs concurrently
- synchronization is done using sync.WaitGroup to ensure all workers complete before exiting
- efficient use of resources compared to spawning a goroutine per job

- Creating a worker pool:
1. Set up a job channel to send tasks
2. Launch multiple goroutines that process jobs from the channel
3. Send tasks through the job channel nd close it when done
		jobs := make(chan int, 100)
		results := make(chan int, 100)
		for w := 1; w <= 3; w++ {
				go worker(w, jobs, results)
		}
		for j := 1; j <= 5; j++ {
				jobs <- j
		}
		close(jobs)
*/

func worker_p(id int, jobs <-chan int, results chan<- int) { // worker of which we'll run several concurrent instances
	for j := range jobs { // these worker will receive work on the jobs channel
		fmt.Println("worker", id, "started  job", j) // and send the corresponding results on results channel
		time.Sleep(time.Second)
		fmt.Println("worker", id, "finished job", j)
		results <- j * 2
	}
}

func worker_pools() {

	const numJobs = 5 // we create 2 channels for sending and receiving job results
	jobs := make(chan int, numJobs)
	results := make(chan int, numJobs)

	for w := 1; w <= 3; w++ { //start up 3 workers, initially blocked because there are no jobs yet
		go worker_p(w, jobs, results)
	}

	for j := 1; j <= numJobs; j++ { // here we send 5 jobs and then close that channel to indicate that's all the work we have
		jobs <- j
	}
	close(jobs)

	for a := 1; a <= numJobs; a++ { // we collect all the results of the work
		<-results // this also ensures that the worker goroutines have finished; an alternative would be to use WaitGroups
	}
	/*	worker 1 started	job 1
		worker 2 started	job 2
		worker 3 started	job 3
		worker 1 finished	job 1
		worker 1 started	job 4
		worker 2 finished job 2
		worker 2 started 	job 5
		worker 3 finished job 3
		worker 1 finished	job 4
		worker 2 finished job 5

		real 0m2.358s	*/

	/* Our running program shows the 5 jobs being executed by various worker.
	The program only takes about 2 seconds despite doing about 5 seconds of total work because there are 3 workers operating concurrently */
}
