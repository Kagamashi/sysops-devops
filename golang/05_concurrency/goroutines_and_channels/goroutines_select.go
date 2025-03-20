package main

import (
	"fmt"
	"time"
)

/* SELECT
Select allows a goroutine to wait on multiple channel operations, proceeding with the first one ready to communicate
select {
case val := <-ch1:
    // Handle data from ch1
case ch2 <- 42:
    // Send data to ch2
default:
    // Optional: handle if no channels are ready
}

- Using a default case makes select non-blocking, allowing the goroutine to move on if no channels are ready
- If multiple channels are ready, Go picks one randomly to avoid bias
- Combining select and time.After enables graceful handling of timeouts when waiting on channels
*/

func select_ch() {

	c1 := make(chan string) //we create two new channels
	c2 := make(chan string)

	go func() { // each channel will receive a value after some amount of time
		time.Sleep(1 * time.Second) // to simulate blocking RPC operations executing in concurrent goroutines
		c1 <- "one"
	}()
	go func() {
		time.Sleep(2 * time.Second)
		c2 <- "two"
	}()

	for i := 0; i < 2; i++ { //we will use select to await both of these values simultaneously, printing each one as it arrives
		select {
		case msg1 := <-c1:
			fmt.Println("received", msg1)
		case msg2 := <-c2:
			fmt.Println("received", msg2)
		}
	}
	// received one
	// received two

	// execution time is only 2 seconds since both the 1 and 2 second Sleeps execute concurrently
}


/* 
SELECT DEFAULT
Basic sends and receives on channels are blocking.
However, we can use select with a default clause to implement non-blocking sends, receives, and even non-blocking multi-way selects.
*/

func select_default() {
	messages := make(chan string)
	signals := make(chan bool)

	select { //non-blocking receive
	case msg := <-messages:
		fmt.Println("received message", msg)
	default:
		fmt.Println("no message received")
	}
	// no message received

	msg := "hi"
	select { // non-blocking send
	case messages <- msg: // msg cannot be sent to the messages channel, because it has no buffer and there is no receiver
		fmt.Println("sent message", msg)
	default:
		fmt.Println("no message sent")
	}
	// no message sent

	select { // we can use multiple cases above the default clause to implement a multi-way non-blocking select
	case msg := <-messages:
		fmt.Println("received message", msg)
	case sig := <-signals:
		fmt.Println("received signal", sig)
	default:
		fmt.Println("no activity")
	}
	// no activity
}
