package main
import "fmt"

/*
Go supports embedding of structs and interfaces to express a more seamless composition of types.

[!] This os not //go:embed - which is go directive used to embed files and folders into the application binary.
*/

type base struct {
	num int
}

func (b base) describe() string {
	return fmt.Sprintf("base with num=%v", b.num)
}

type container struct { // a container embeds a base.
	base // embedding looks like a field without a name
	str  string
}

func struct_embedding() { //"main"

	co := container{ // when creating structs with literals, we have to initialize the embedding explicity
		base: base{ // here the embedded type serves as the field name
			num: 1,
		},
		str: "some name",
	}

	fmt.Printf("co={num: %v, str: %v}\n", co.num, co.str) // we can access the base fields directly on co, e.g. co.num
	// co={num: 1, str: some name}

	fmt.Println("also num:", co.base.num) // alternatively, we can spell out the full path using embedded type name
	// also num: 1

	fmt.Println("describe:", co.describe()) // since container embeds base, the methods of base also become methods of container - here we invoke a method that was embedded from base directly on co
	// describe: base with num=1

	type describer interface {
		describe() string
	}

	var d describer = co                    // embedding structs with methods may be used to bestow interface implementation onto other structs
	fmt.Println("describer:", d.describe()) // here we see that a container now implements the describer interface because it embeds base
	// describer: base with num=1

}
