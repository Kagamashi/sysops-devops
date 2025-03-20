package main
import (
	"fmt"
	"time"
)

/*
We can use channel to synchronize execution across goroutines.
In the example we are using blocking receive to wait for a goroutine to finish.
If waiting for multiple goroutines to finish, use WaitGroups
https://gobyexample.com./waitgroups
*/

func worker(done chan bool) { //function that will be run in goroutine
	fmt.Print("working...") //done channel will be used to notify another goroutine that this function's work is done
	time.Sleep(time.Second)
	fmt.Println("done")

	done <- true //send a value that we are done
}

func channel_synchronization() {

	done := make(chan bool, 1) //start a worker goroutine, giving it the channel to notify on
	go worker(done)

	<-done //block until we receive a notification from the worker on the channel
	// working...done

	/*
		If we remove the <- done line from the program
		the program would exit before the worker even started
	*/
}
