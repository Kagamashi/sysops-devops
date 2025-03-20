package main
import "fmt"

/* 
- GO infer type if not explicitly states
- shorthand syntax inside functions ':='
- declaration of multiple variables at once:
		var x, y int = 1, 2
		x, y := 1, 2
- variable names starting with a capital letter are exported and accessible from other packages;
	lowercase ones are package-private
*/

func variables() {

	var a = "initial" // var declares 1 or more variables (here without stating type)
	fmt.Println(a)

	var b, c int = 1, 2 // you can declare multiple variables at once
	fmt.Println(b, c)

	var d = true // go will infer the type of initialized variables
	fmt.Println(d)

	var e int // variables declared without initilization are zero-valued
	fmt.Println(e)

	f := "apple"   // := syntax is shorthand for declaring and initializing a variable
	fmt.Println(f) // this syntax is only available inside functions
}
