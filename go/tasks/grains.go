package task

import "errors"

func Total() uint64 {
	return (1 << 64) - 1
	// binary shift operator (<<) directly computes owers of 2 without floating-point errors
	// formula for sum of geometric series: (2^n-1)/(2-1)
}

func Square(n int) (uint64, error) {
	if 1 > n || n > 64 {
		return uint64(0), errors.New("Invalid")
	}

	return uint64(1 << uint(n-1)), nil // calculates 2^(n-1) which represent number of grains on the n-th square of chessboard
}

// https://stackoverflow.com/questions/5801008/go-and-operators

//////

