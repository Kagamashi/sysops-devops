package main
import (
	"fmt"
	"time"
)

/* 
switch is used for multi-way branching based on the value of an expression

- Multiple values can be listed for a single case
	case "A", "B", "C":
		// shared block for A, B, C

- switch without an expression acts like switch true, allowing complex conditional logic
	switch {
	case x < 0:
		// negative case
	case x == 0:
		// zero case
	default:
		// positive case
	}
*/

func switch_statement() {

	i := 2
	fmt.Print("Write ", i, " as ")
	switch i {
	case 1:
		fmt.Println("one")
	case 2:
		fmt.Println("two")
	case 3:
		fmt.Println("three")
	}
	// Write 2 as two

	switch time.Now().Weekday() {
	case time.Saturday, time.Sunday: //separate multiple expressions in the same case statement with commas
		fmt.Println("It's the weekend")
	default: //default case
		fmt.Println("It's a weekday")
	}

	t := time.Now()
	switch { //switch without an expression is a way to express if/else logic
	case t.Hour() < 12:
		fmt.Println("It's before noon")
	default:
		fmt.Println("It's after noon")
	}

	whatAmI := func(i interface{}) {
		switch t := i.(type) { //type switch compares types instead of values
		case bool: //variable t will have the type corresponding to its clause
			fmt.Println("I'm a bool")
		case int:
			fmt.Println("I'm an int")
		default:
			fmt.Printf("Don't know type %T\n", t)
		}
	}
	whatAmI(true)
	whatAmI(1)
	whatAmI("hey")
}
