package main
import (
	"fmt"
	"time"
	"context"
)

/*
context package provides a way to manage timeouts, cancellations and request-scoped values in concurrent Go program

	context.Backgroun()		root context, used when no parent context is available
	context.TODO()				placeholder for when context usage is undecided
	context.WithCancel(parent)		derived context that can be canceled manually
		when cancel is called all goroutines exit gracefully
	context.WithTimeout(parent, duration)		derived context that cancels after given duration
		if operations takes longer than X it gets cancelled
*/

func worker_ctx(ctx context.Context, id int) {
	for {
		select {
		case <-ctx.Done():
			fmt.Println("Worker", id, "stopping")
			return
		default:
			fmt.Println("Worker", id, "working")
			time.Sleep(500 * time.Millisecond)
		}
	}
}

func context_package() {
	ctx, cancel := context.WithCancel(context.Background())

	for i := 1; i <= 3; i++ {
		go worker_ctx(ctx, i)
	}

	time.Sleep(2 * time.Second)
	cancel() // Stop all workers
	time.Sleep(time.Second)
}
