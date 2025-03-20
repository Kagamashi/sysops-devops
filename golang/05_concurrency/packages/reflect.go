package main
import (
	"fmt"
	"reflect"
)

/*
reflect package allows working with dynamic types and values at runtime

reflect.TypeOf(x)			Returns the type of x
reflect.ValueOf(x)		Returns the value of x
reflect.Value.Type()	Gets the type from a reflect.Value
reflect.Kind					Determines the kind (e.g., struct, slice, int, etc.)
reflect.New(Type)			Creates a new instance of a type
reflect.Set()					Modifies a value (requires Value.CanSet() to be true)
*/

func modifyValue(x interface{}) {
	v := reflect.ValueOf(x)
	if v.Kind() == reflect.Ptr && v.Elem().CanSet() {
		v.Elem().SetInt(100) // Only works if x is a pointer to an int
	}
}

// reflection is often use to read struct field tags, especially for JSON serialization
type User struct {
	Name string `json:"name"`
	Age  int    `json:"age"`
}
func readTags(i interface{}) {
	t := reflect.TypeOf(i)
	for i := 0; i < t.NumField(); i++ {
		field := t.Field(i)
		fmt.Printf("Field: %s, Tag: %s\n", field.Name, field.Tag.Get("json"))
	}
}

func reflect_package() {
	x := 42
	fmt.Println("Type:", reflect.TypeOf(x))   // int
	fmt.Println("Kind:", reflect.ValueOf(x).Kind()) // int

	y := "Hello"
	fmt.Println("Type:", reflect.TypeOf(y))   // string

	val := 42
	modifyValue(&val)
	fmt.Println(val) // 100

	u := User{Name: "Alice", Age: 30}
	readTags(u)
}
