package task

import (
    "errors"
    "strconv"
    "unicode"
)

// LargestSeriesProduct calculates the largest product of 'span' adjacent digits in 'digits'.
func LargestSeriesProduct(digits string, span int) (int64, error) {
    if span <= 0 || span > len(digits) {
        return 0, errors.New("invalid span or digits length")
    }

    for _, r := range digits {
        if !unicode.IsDigit(r) {
            return 0, errors.New("contains non-digit characters")
        }
    }

    var maxProduct int64

    for i := 0; i <= len(digits)-span; i++ {
        sub := digits[i : i+span]
        product := multiply(sub)
        if product > maxProduct {
            maxProduct = product
        }
    }

    return maxProduct, nil
}

// multiply calculates the product of all digits in a string of numeric characters.
func multiply(sub string) int64 {
    var product int64 = 1
    for _, r := range sub {
        n, _ := strconv.Atoi(string(r))
        product *= int64(n)
    }

    return product
}
