package main
import (
	"errors"
	"fmt"
)

/* 
errors in Go are communicated via an explicit separate return value.
Errors are handled using the same language constructs employed for other, non-error tasks.

- Errors are values of the built-in error type, which is an interface with a single method Error() string
- Errors are typically returned as the last value from a function
		fmt.Errorf("%w", err) to wrap error with additional context
		errors.Unwrap(err) to retrieve the original error
- Errors are used for expected conditions (panic for unrecoverable conditions)
		errors.Is() used to compare wrapped errors
		errors.As() to check for specific error types in error chains

https://pkg.go.dev/errors
https://go.dev/blog/go1.13-errors
*/

// error interface is built into Go
type error interface {
    Error() string
}

func f(arg int) (int, error) { // By convention errors are the last return value and have type error, a built-in interface
	if arg == 42 {

		return -1, errors.New("can't work with 42") // errors.New constructs a basic error value with the given message
	}

	return arg + 3, nil // nil value in the error position indicates that there was no error
}

var ErrOutOfTea = fmt.Errorf("no more tea available") // a sentinel error is a predeclared variable that is used to signify a specific error condition
var ErrPower = fmt.Errorf("can't boil water")

func makeTea(arg int) error {
	if arg == 2 {
		return ErrOutOfTea
	} else if arg == 4 {
		// we can wrap errors with higher-level errors to add context
		return fmt.Errorf("making tea: %w", ErrPower) // simplest way to do this is with %w verb in fmt.Errorf
	}
	return nil
}

func error_def() {
	for _, i := range []int{7, 42} {

		if r, e := f(i); e != nil { // it's common to use an inline error check in the if line
			fmt.Println("f failed:", e)
		} else {
			fmt.Println("f worked:", r)
		}
	}
	//  f worked: 10
	//  f failed: can't work with 42

	for i := range 5 {
		if err := makeTea(i); err != nil {

			if errors.Is(err, ErrOutOfTea) {
				fmt.Println("We should buy new tea!")
			} else if errors.Is(err, ErrPower) { // errors.Is checks that a given error (or any error in the chain) matches a specific error value
				fmt.Println("Now it is dark.")
			} else {
				fmt.Printf("unknown error: %s\n", err)
			}
			continue
		}

		fmt.Println("Tea is ready!")
	}
	// Tea is ready!
	// Tea is ready!
	// We should buy new tea!
	// Tea is ready!
	// Now it is dark.

}
