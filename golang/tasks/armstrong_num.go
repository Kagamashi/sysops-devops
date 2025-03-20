package task

import "math"

func IsNumber(n int) bool {
    if n < 0 {
        return false
    }
    
    sum := 0
    original := n

    numDigits := int(math.Log10(float64(n))) + 1

	for n > 0 {
        digit := n % 10
        sum += int(math.Pow(float64(digit), float64(numDigits)))
		n /= 10
    }
    
    return sum == original
}
