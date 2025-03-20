package main
import "fmt"

/*
By default channels are UNBUFFERED, meaning they will only accept sends (chan <-)
if there is a corresponding receive (<- chan) ready to receive the sent value.

Buffered channels accept a limited number of values without a corresponding receiver for those values.
*/

func channel_bufering() {

	messages := make(chan string, 2) //channel of strings up to 2 values

	messages <- "buffered" //because channel is buffered, we can send these values into the channel
	messages <- "channel"  // without a corresponding concurrent receive

	fmt.Println(<-messages) // buffered
	fmt.Println(<-messages) // channel
}
