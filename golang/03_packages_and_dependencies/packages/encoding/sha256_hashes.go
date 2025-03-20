package main

import (
	"crypto/sha256"
	"fmt"
)

/* SHA256 HASHES
crypto/sha256 package provides functionality to compute SHA256 cryptographic hashes, commonly used for integrity checks, digital signatures and security purposes.

sha256.New() - creates new SHA-256 hash instance
sha256.Sum256(data []byte) - directly computes SHA256 checksum of the provided byte slice
h.Write(data) - adds data to hash instance
h.Sum(nil) - returns finalized hash as a byte slice

- Resulting hash is a byte slice, represented as hexadecimal string using %x in fmt.Printf
- For larger data we can use streaming approach with sha256.New(), followed by Write calls and Sum(nil)
https://en.wikipedia.org/wiki/Cryptographic_hash_function
*/

func sha256_hashes() {
	s := "sha256 this string"

	h := sha256.New()

	h.Write([]byte(s)) // Write expects bytes

	bs := h.Sum(nil) // Finalized hash result as a byte slice

	fmt.Println(s)
	// sha256 this string
	fmt.Printf("%x\n", bs)
	// 1af1dfa857bf1d8814fe1af8983c18080019922e557f15a8a...

}
