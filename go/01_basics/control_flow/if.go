package main
import "fmt"

/* 
used for conditional execution of code based on Boolean expressions
- Variables can be declared within the if statement and they are locally scoped
- Go does not support a tenary operator (? :) - use if-else blocks instead
*/

func if_else() {

	if 7%2 == 0 {
		fmt.Println("7 is even")
	} else {
		fmt.Println("7 is odd")
	}

	if 8%4 == 0 { // if can exist without an else
		fmt.Println("8 is divisible by 4")
	}

	if 8%2 == 0 || 7%2 == 0 { // supports logical operators ||, &&, !=, ==
		fmt.Println("either 8 or 7 are even")
	}

	if num := 9; num < 0 { // variables declared in statement are available in the current/subsequent branches
		fmt.Println(num, "is negative")
	} else if num < 10 {
		fmt.Println(num, "has 1 digit")
	} 
	// 9 has 1 digit

	// parentheses around conditions are not needed in Go
	// but braces are required
}
