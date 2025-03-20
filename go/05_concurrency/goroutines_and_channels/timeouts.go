package main
import (
	"fmt"
	"time"
)

/*
Timeouts in Go are managed by using time.After function which returns a channel that sends the current time after a specified duration.
	select {
	case res := <-ch:
		// Handle result
	case <-time.After(2 * time.Second):
		// Handle timeout
	}
- time.After channel blocks for the specified time and can be used to impose time limits on operations like waiting for data from another channel
*/

func timeouts() {

	c1 := make(chan string, 1) //external call that returns it's result on a channel c1 after 2s
	go func() {                // channel is buffered so the send in the goroutine is nonblocking
		time.Sleep(2 * time.Second) // this is a common pattern to prevent goroutine leaks in case the channel is never read
		c1 <- "result 1"
	}()

	select { // select that implements a timeout
	case res := <-c1: // awaits the result
		fmt.Println(res)
	case <-time.After(1 * time.Second): // awaits a value to be sent after the timeout of 1s
		fmt.Println("timeout 1") // since select proceeeds with the first receive thats ready, it will take timeout case if the operation takes more than the allowed 1s
	}
	// timeout 1

	c2 := make(chan string, 1) // if we allow a longer timeout of 3s, then the receive from c2 will succeed and we'll print the result
	go func() {
		time.Sleep(2 * time.Second)
		c2 <- "result 2"
	}()

	select {
	case res := <-c2:
		fmt.Println(res)
	case <-time.After(3 * time.Second):
		fmt.Println("timeout 2")
	}
	// result 2
}
