package main

import (
	"fmt"
	"math/rand/v2"
)

/* RANDOM NUMBERS
math/rand package provides functions to generate random numbers and perform randomization tasks
rand.IntN(n int) - returns non-negative random ionteger less than n
rand.Float64()

- Package generates pseudo-random numbers, which are deterministic based on the seed value
- Always seed random number generator to ensure different random sequences on each run
Use time.Now().UnixNano() for unique seed
*/

func random_numbers() {

	fmt.Print(rand.IntN(100), ",")
	fmt.Print(rand.IntN(100)) // Returns random int n, 0 <= n < 100
	fmt.Println()
	// 16,7

	fmt.Println(rand.Float64()) // Returns float64 f, 0.0 <= f < 1.0
	// 0.9512324466746034

	fmt.Print((rand.Float64()*5)+5, ",") // Used to generate rando floats in other ranges
	fmt.Print((rand.Float64() * 5) + 5)
	fmt.Println()
	// 8.628971867016359,9.376158421206293

	s2 := rand.NewPCG(42, 1024) // Creates a new seed source that requires two uint64 numbers
	r2 := rand.New(s2)
	fmt.Print(r2.IntN(100), ",")
	fmt.Print(r2.IntN(100))
	fmt.Println()
	// 94,49

	s3 := rand.NewPCG(42, 1024)
	r3 := rand.New(s3)
	fmt.Print(r3.IntN(100), ",")
	fmt.Print(r3.IntN(100))
	fmt.Println()
	// 94,49

}
