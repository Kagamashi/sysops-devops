package task

import "errors"

func ToRomanNumeral(input int) (string, error) {

    if input <= 0 || input >= 4000 {
        return "", errors.New("Invalid input.")
    }
    
    var romanNumerals = []struct {
    	value int
    	numeral string
    }{
        {1000, "M"}, {900, "CM"}, {500, "D"}, {400, "CD"},
        {100, "C"}, {90, "XC"}, {50, "L"}, {40, "XL"},
        {10, "X"}, {9, "IX"}, {5, "V"}, {4, "IV"}, {1, "I"},
    }

	var result string
    
    for _, pair := range romanNumerals {
        for input >= pair.value {
            result += pair.numeral
            input -= pair.value
        }
    }

    return result, nil
}
