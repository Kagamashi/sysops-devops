package main
import (
	"fmt"
	"math"
)

/*
Constants are individual fixed values
const Pi = 3.14
- Constants are immutable (once declared their values cannot be changed)
- Constants without an explicit type are "untyped" and can be used with various types depending on context
*/

const s string = "constant"

func constants() {

	fmt.Println(s)
	//constant

	const n = 500000000 // const statement can appear anywhere a var statement can

	const d = 3e20 / n // constants perform arimetrics with arbitraty precision
	fmt.Println(d)
	//6e+11

	fmt.Println(int64(d)) // numeric constant has no type until it's given one; for example by explicit conversion

	// a number can be given type by using it in a context that requires one such as variable assignment or functions call
	fmt.Println(math.Sin(n)) // math.Sin expects a float64 so it infers n as float64
	//	-0.2047040732375440

	const ( // multiple constants can be declared at once using parentheses
		A = 1
		B = 2
	)

	// related to Enums
	const ( // iota - is a special constant used for enumerated constants, which incremenets automatically
		C0 = iota // C0 == 0
		C1 = iota // C1 == 1
		C2 = iota // C2 == 2
	)
}


/* 
ENUMS
Enumerated types (enums) represent a collection of related constants (https://en.wikipedia.org/wiki/Algebraic_data_type)
Enum is a type that has a fixed number of possible values, each with a distinct name.
Go doesn't have an enum type as a distinct language feature, but enums are simple to implement using existing language idioms.

- Enums are typically implemented using iota keyword which auto-increments constants
- Enums can be typed (type Color int) or untyped based on the use case
- Stringer interface can be implemented to provide human-readable names for enum values
- Enums are often used to represent a set of related values such as: status code, days of the week, configuration states.

- Since there is no true enum type in Go - enums are essentially just constants :)

https://pkg.go.dev/golang.org/x/tools/cmd/stringer
https://eli.thegreenplace.net/2021/a-comprehensive-guide-to-go-generate
*/

// TYPE refers to classification of values and variables, specifying the kind of data they hold and the operations that can be performed on them.
type ServerState int // our enum type ServerState has an underying int type

const ( // possible values for ServerState are defined as constants
	StateIdle = iota // special keyword iota generated successive constant values automatically; in this case 0, 1, 2..
	StateConnected
	StateError
	StateRetrying
)

var stateName = map[ServerState]string{ // by implementing fmt.Stringer interface, vales of ServerState can be printed out or converted to strings
	StateIdle:      "idle",
	StateConnected: "connected",
	StateError:     "error",
	StateRetrying:  "retrying",
}

func (ss ServerState) String() string {
	return stateName[ss]
}

func enums() { // if we have a value of type int we cannot pass it to transition
	ns := transition(StateIdle) //the compiler will complain about type mismatch - this provides some degree of compile-time safety for enums
	fmt.Println(ns)
	// connected

	ns2 := transition(ns)
	fmt.Println(ns2)
	// idle
}

func transition(s ServerState) ServerState { // transition emulates a state transition for a server; it takes the existing state and returns a new state
	switch s {
	case StateIdle:
		return StateConnected
	case StateConnected, StateRetrying:
		return StateIdle // we check some predicates here to determine the next state
	case StateError:
		return StateError
	default:
		panic(fmt.Errorf("unknown state: %s", s))
	}
}
