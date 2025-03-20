package main
import "fmt"

/*
Closing a channel indicates that no more values will be sent on it.
Useful to communicate completion to the channel's receivers.

- Channels should be closed using 'close(ch)' to indicate no more values will be sent
*/

func channel_closing() {
	jobs := make(chan int, 5)
	done := make(chan bool)

	go func() { //worker goroutine; it repeatedly receives from jobs with j, more := <-jobs
		for { // in this 2-value form of receive, the more value will be false if jobs has been closed and all values in the channel have already been received
			j, more := <-jobs
			if more {
				fmt.Println("received job", j)
			} else {
				fmt.Println("received all jobs")
				done <- true // synchronization approach
				return
			}
		}
	}()

	for j := 1; j <= 3; j++ { //send 3 jobs to the worker over the jobs channel then closes it
		jobs <- j
		fmt.Println("sent job", j)
	}
	close(jobs) // closing the channel
	fmt.Println("sent all jobs")

	<-done // await the worker using the synchronization approach

	_, ok := <-jobs                        // reading from a closed channel succeeds immediately returning the zero value of the underlying type
	fmt.Println("received more jobs:", ok) // optional second return value is true if the value received was delivered by a successful send operation to the channel  or false if it was a zero value generated because the channel is closed and empty

	/*  sent job 1
	received job 1
	sent job 2
	received job 2
	sent job 3
	received job 3
	sent all jobs
	received all jobs
	received more jobs: false	*/
}
