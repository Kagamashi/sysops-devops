package task

func Sieve(limit int) []int {
	primes := make([]bool, limit+1)

    for i := 2; i <= limit; i++ {
        primes[i] = true
    }

    for p := 2; p*p <= limit; p++ {
        if primes[p] {
            for i := p*p; i <= limit; i += p {
                primes[i] = false
            }
        }
    }

    var primeNumbers []int
    for p := 2; p <= limit; p++ {
        if primes[p] {
            primeNumbers = append(primeNumbers, p)
        }
    }

    return primeNumbers
}
