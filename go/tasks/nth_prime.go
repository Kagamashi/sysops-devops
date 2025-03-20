package task

import (
	"errors"
	"math"
)

var primes = []int{2}

// isPrime checks if a number is prime using the list of known primes.
func isPrime(n int) bool {
	limit := int(math.Sqrt(float64(n))) // square root of n
	for _, p := range primes {
		if p > limit { // stop checking if p > sqrt(n)
			break
		}
		if n%p == 0 {
			return false
		}
	}
	return true
}

// Nth returns the nth prime number.
func Nth(n int) (int, error) {
	if n < 1 {
		return 0, errors.New("there is no zeroth prime")
	}

	for i := primes[len(primes)-1] + 1; len(primes) < n; i++ {
		if isPrime(i) {
			primes = append(primes, i)
		}
	}

	return primes[n-1], nil
}
