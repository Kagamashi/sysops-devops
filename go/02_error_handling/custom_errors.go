package main
import (
	"errors"
	"fmt"
)

/* CUSTOM ERRORS
It's possible to use custom types as errors by implementing Error() method on them.
*/

type argError struct { //custom error type usually has the suffix 'Error'
	arg     int
	message string
}

func (e *argError) Error() string { // adding this Error method makes argError implement the error interface
	return fmt.Sprintf("%d - %s", e.arg, e.message)
}

func fc(arg int) (int, error) {
	if arg == 42 {

		return -1, &argError{arg, "can't work with it"} //return our custom error
	}
	return arg + 3, nil
}

func custom_error_defn() {

	_, err := fc(42) //errors.As is a more advanced version of errors.Is
	var ae *argError //it checks that given error matches a specific error type and convert to a value of that type, returning true
	if errors.As(err, &ae) {
		fmt.Println(ae.arg)
		fmt.Println(ae.message)
	} else {
		fmt.Println("err doesn't match argError")
	}
	// 42
	// can't work with it

}
