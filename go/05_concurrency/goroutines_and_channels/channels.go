package main
import "fmt"

/* 
Channels are Go's primary mechanism for communication between goroutines allowing them to safely share data.
- Channels are declared using chan keyword:
				ch := make(chan int)
- Channels are typed, they can only transport a specific type of data
- Synchronous communication - sending/receiving from a channel are blocking until both the sender and receiver are ready
- Channels can hold a specific number of values:
ch := make(chan int, 2)
- Sending and receiveing data to/from channel:
		ch <- value
		val := <-ch
- Channel can be directional - restricted to either sending or receiving
		func sendOnly(ch chan<- int) {ch <- 42}
		func receiveOnly(ch <-chan int) {val := <-ch}
- Channels should be closed using 'close(ch)' to indicate no more values will be sent
*/

func channels() {

	messages := make(chan string) //create new channel - channels are typed by the values they convey

	go func() { messages <- "ping" }() // send a value into a channel using channel <-sytanx - here we send "ping" to the messages channel

	msg := <-messages // <-channel syntax receives a value from the channel
	fmt.Println(msg) // ping

	// When we run the program the 'ping' message is successfully passed from one goroutine to another via our channel.
}
