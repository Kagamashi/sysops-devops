package main

import (
	"fmt"
	"os"
	"os/signal"
	"syscall"
)

/* SIGNALS
Use os/signal to listen for system signals (e.g. SIGINT) and handle them.

Signals are used to communicate with running processes (e.g. sending termination signals).
os/signal package allows Go programs to listen for and handle system signals
- Handling multiple signals:
signal.Notify(sigs, syscall.SIGINT, syscall.SIGTERM, syscall.SIGHUP)

- Common functions:
signal.Notify(c chan<- os.Signal, sig ...os.Signal) - registers a channel to receive specified signals
signal.Ignore(sig ...os.Signal) - ignores specified signals
signal.Stop(c chan<- os.Signal) - stops signal delivery to the given channel
*/

func signals() {

	sigs := make(chan os.Signal, 1) // Go signal notification works by sending os.Signal values on a channel - this channel should be BUFFERED

	signal.Notify(sigs, syscall.SIGINT, syscall.SIGTERM) // signal.Notify registers the given channel to receive notifications of the specified signals

	done := make(chan bool, 1)

	go func() { // This goroutine executes a blocking receive for signals

		sig := <-sigs // Receive signal
		fmt.Println()
		fmt.Println(sig) // Print signal out
		done <- true     // Notify the program that it can finish
	}()

	fmt.Println("awaiting signal") // Program waits here until it gets the expected signal
	<-done
	fmt.Println("exiting")

	/*
		Program will block waitinf for a signal; by typing ctrl-C we can send SIGINT signal,
		causing the program to print interrupt and then exit.

		$ go run signals.go
		awaiting signal
		^C
		interrupt
		exiting
	*/

}
