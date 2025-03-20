package main
import (
	"fmt"
)

/* 
pipeline consists of multiple stages where each stage performs some computation and passes the result to the next stage via channels
this is useful for processing streams of data efficiently.

- each pipeline stage processes data and passes it to the next
- channels connect the stages to maintain concurrency
- stages run in separate goroutines, enabling parallel execution
*/

// Generator function creates a stream of numbers
func generator(nums ...int) <-chan int {
	out := make(chan int)
	go func() {
		for _, n := range nums {
			out <- n
		}
		close(out)
	}()
	return out
}

// Square function processes numbers from the input channel
func square(in <-chan int) <-chan int {
	out := make(chan int)
	go func() {
		for n := range in {
			out <- n * n
		}
		close(out)
	}()
	return out
}

// Double function processes numbers from the square stage
func double(in <-chan int) <-chan int {
	out := make(chan int)
	go func() {
		for n := range in {
			out <- n * 2
		}
		close(out)
	}()
	return out
}

func pipeline_pattern() {
	nums := generator(1, 2, 3, 4, 5) // Stage 1
	squares := square(nums)          // Stage 2
	doubles := double(squares)       // Stage 3

	// Collect and print results
	for result := range doubles {
		fmt.Println("Processed:", result)
	}
}
