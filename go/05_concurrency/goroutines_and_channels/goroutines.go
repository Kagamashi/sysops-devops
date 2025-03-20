package main
import (
	"fmt"
	"time"
)

/*
Goroutine is a lightweight thread of execution
- Goroutines enable concurrent execution and are schedules by Go's runtime across available CPU cores
- Goroutine is launched by prefixing a function call with go keyword:
go someFunction()
- Goroutines communicate using channels allowing safe data sharing without explicit locking
ch := make(chan int)
- Goroutine is non-blocking, main function may exit before a goroutine completes
- Synchronization tools like sync.WaitGroup to wair for goroutines to finish
- Thousands of goroutines can run concurrently making Go highly scalable
*/

func f(from string) {
	for i := 0; i < 3; i++ {
		fmt.Println(from, ":", i)
	}
}

func goroutine() {

	f("direct") // usual call of the function called f(s)

	go f("goroutine") // to invoke a goroutine we use 'go f(s)'

	go func(msg string) { // we can also start goroutine for an anonymous function call
		fmt.Println(msg)
	}("going")

	time.Sleep(time.Second) //our two function calls are running asynchronously in separate goroutines now
	fmt.Println("done")
	/*
		direct : 0
		direct : 1
		direct : 2
		goroutine : 0
		going
		goroutine : 1
		goroutine : 2
		done
	*/

	/*
		When this program is run, we see the output of the blocking call first.
		Then the output of the two goroutines.
		Goroutines output may be interleaved because goroutines are being run concurrently by the Go runtime.
	*/
}
