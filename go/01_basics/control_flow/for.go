package main
import "fmt"

/*
for is the only looping construct in Go
- Loop can be infinite for {}
- Use 'break' to exit the loop
- Use 'continue' to skip the current iteration
- Multiple variables can be updated in for loop
		for i, j := 0, 0; i < 5 && j < 5; j = i+1, j+2 {
			// loop body
		}
*/

func for_loop() {
	i := 1
	for i <= 3 { // single condition - similar to while loop
		fmt.Println(i)
		i = i + 1
	}

	for j := 0; j < 3; j++ { // initial/condition/after for loop
		fmt.Println(j)
	}

	for i := range 3 { // range over an integer - "do this N times" iteration
		fmt.Println("range", i)
	}

	for { // for without condition will loop repeatedly until we break out of it or return from enclosing function
		fmt.Println("loop")
		break
	}

	for n := range 6 { // we can also continue to the next iteration of the loop
		if n%2 == 0 {
			continue
		}
		fmt.Println(n)
	}
}
