// # 2429. Minimize XOR

package leetcode

import (
	"math/bits"
)

func minimizeXor(num1 int, num2 int) int {
	// Count the number of set bits in num2
	setBitsNum2 := bits.OnesCount(uint(num2))

	// Initialize x to 0
	x := 0

	// Iterate over bits from the most significant to the least significant
	for i := 31; i >= 0 && setBitsNum2 > 0; i-- {
		if num1&(1<<i) != 0 {
			// Set the corresponding bit in x
			x |= (1 << i)
			setBitsNum2--
		}
	}

	// If there are still bits to set
	for i := 0; i <= 31 && setBitsNum2 > 0; i++ {
		if x&(1<<i) == 0 {
			// Set the bit in x
			x |= (1 << i)
			setBitsNum2--
		}
	}

	return x
}