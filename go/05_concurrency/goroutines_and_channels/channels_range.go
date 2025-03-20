package main
import "fmt"

/*
We can iterate over values received from a channel the same way as over built in types
*/

func range_over_channels() {
	queue := make(chan string, 2) //we iterate over 2 values in queue channel
	queue <- "one"
	queue <- "two"
	close(queue)

	for elem := range queue { // this range iterates over each element as it's received from queue
		fmt.Println(elem) // because the channel is closed, the iteration terminates after receiving the 2 elements
	}
	// one
	// two

	// this shows that it's possible to close a non-empty channel but still have the remaining values be received
}
