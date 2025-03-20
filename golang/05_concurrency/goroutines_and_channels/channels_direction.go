package main
import "fmt"

/*
Channel can be directional - restricted to either sending or receiving
	func sendOnly(ch chan<- int) {ch <- 42}
	func receiveOnly(ch <-chan int) {val := <-ch}
*/

func ping(pings chan<- string, msg string) { //this function only accepts a channel for sending value
	pings <- msg
}

func pong(pings <-chan string, pongs chan<- string) { //this function accepts one channel for receives (pings) and a second for sends (pongs)
	msg := <-pings
	pongs <- msg
}

func channel_directions() {
	pings := make(chan string, 1)
	pongs := make(chan string, 1)
	ping(pings, "passed message")
	pong(pings, pongs)
	fmt.Println(<-pongs) // passed message
}
