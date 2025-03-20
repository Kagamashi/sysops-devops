package main
import "fmt"

/* 
ZERO VALUES
int : 0
float : 0.0
complex: 0 + 0i
bool : false
string : ""
*T (any pointer type) : nil
slice : nil
map : nil
channel : nil
interface : nil
struct : each field in a struct gets it's corresponding zero value
*/

func values() {
	fmt.Println("go" + "lang")
	//golang

	fmt.Println("1+1 =", 1+1)
	//1+1 = 2

	fmt.Println("7.0/3.0 =", 7.0/3.0)
	// 7.0/3.09 = 2.3333333335

	fmt.Println(true && false)
	//false

	fmt.Println(true || false)
	//true

	fmt.Println(!true)
	//false
}
