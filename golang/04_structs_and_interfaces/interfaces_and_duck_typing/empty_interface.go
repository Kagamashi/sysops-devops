package main
import "fmt"

/*
empty interface interface{} can hold any type
since all types implicitly implement interface{} it is useful for generic programming

[!] it removes compile-time type safety
*/

// Function accepting any type (lacks type safety)
func PrintValue(v interface{}) {
	fmt.Println("Value:", v)
}

func empty_interface() {
	PrintValue(42)         // Value: 42
	PrintValue("hello")    // Value: hello
	PrintValue(3.14)       // Value: 3.14
	PrintValue([]int{1, 2, 3}) // Value: [1 2 3]
}

// safe type assertion (ok idiom) prevents runtime panics
// if x doesn't hold a string, ok will be false
func type_assertion() {
	var x interface{} = "golang"

	// Type assertion
	str, ok := x.(string)
	if ok {
		fmt.Println("String:", str) // String: golang
	} else {
		fmt.Println("Not a string")
	}
}

func identifyType(i interface{}) {
	switch v := i.(type) {
	case int:
		fmt.Println("Integer:", v)
	case string:
		fmt.Println("String:", v)
	case bool:
		fmt.Println("Boolean:", v)
	default:
		fmt.Println("Unknown type")
	}
}

// type switch helps work with dynamic types stored in an interface{}
func type_switch() {
	identifyType(42)      // Integer: 42
	identifyType("hello") // String: hello
	identifyType(true)    // Boolean: true
	identifyType(3.14)    // Unknown type
}
