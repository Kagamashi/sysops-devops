package task

import (
    "strings"
    "unicode"
)

type Frequency map[string]int

func WordCount(phrase string) Frequency {
	freq := Frequency{}

	phrase = strings.ToLower(phrase)
	runes := []rune(phrase)

	var sb strings.Builder
	for i, r := range runes {
		switch {
		case unicode.IsLetter(r) || unicode.IsDigit(r):
			sb.WriteRune(r)
		case r == '\'' && i > 0 && i < len(runes)-1 &&
			(unicode.IsLetter(runes[i-1]) || unicode.IsDigit(runes[i-1])) &&
			(unicode.IsLetter(runes[i+1]) || unicode.IsDigit(runes[i+1])):
			sb.WriteRune(r)
		default:
			// Any other punctuation or whitespace becomes a space delimiter
			sb.WriteRune(' ')
		}
	}

	for _, w := range strings.Fields(sb.String()) {
		freq[w]++
	}

	return freq
}
