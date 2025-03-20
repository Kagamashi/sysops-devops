package task

import (
    "strings"
)


type shift int

type vigenere string

type Cipher interface {
	Encode(string) string
	Decode(string) string
}

// NewCaesar returns a Cipher interface implemented by a shift of 3, representing the classic Caesar cipher.
func NewCaesar() Cipher {
	return NewShift(3)
}

// NewShift returns a Cipher interface implemented by a shift of the specified distance.
func NewShift(distance int) Cipher {
    if distance == 0 || distance < -25 || distance > 25 {
        return nil
    }

    return shift(distance)
}


func (c shift) Encode(input string) string {
    return shiftString(input, int(c))
}

func (c shift) Decode(input string) string {
    return shiftString(input, -int(c))
}

// shiftString applies a shift cipher to the input string with the specified distance.
func shiftString(input string, distance int) string {
    var result strings.Builder
    for _, r := range strings.ToLower(input) {
        if r >= 'a' && r <= 'z' {
            // Calculate the shifted character, wrapping around the alphabet using modulo arithmetic.
            shifted := 'a' + (r-'a'+rune(distance)+26)%26
            result.WriteRune(shifted)
        }
    }
    return result.String()
}

// NewVigenere returns a Cipher interface implemented by the given key.
func NewVigenere(key string) Cipher {
	if len(key) == 0 || strings.Trim(key, "a") == "" {
        return nil
    }

    for _, r := range key {
        if r < 'a' || r > 'z' {
            return nil
        }
    }

    return vigenere(key)
}

func (v vigenere) Encode(input string) string {
    return vigenereString(input, string(v), true)
}

func (v vigenere) Decode(input string) string {
    return vigenereString(input, string(v), false)
}

// vigenereString applies the Vigenère cipher to the input string.
// 'encode' parameter determines whether to encode (true) or decode (false).
func vigenereString(input, key string, encode bool) string {
    var result strings.Builder
    keyShifts := make([]int, len(key))
    for i, r := range key {
        shift := int(r - 'a')
        if !encode {
            shift = -shift // reverse shift for decoding
        }
        keyShifts[i] = shift
    }

    keyIndex := 0
    for _, r := range strings.ToLower(input) {
        if r >= 'a' && r <= 'z' {
            shift := keyShifts[keyIndex]
            // Calculate the shifted character, wrapping around the alphabet using modulo arithmetic.
            shifted := 'a' + (r-'a'+rune(shift)+26)%26
            result.WriteRune(shifted)
            keyIndex = (keyIndex + 1) % len(key)  // Cycle through the key.
        }
    }
    return result.String()
}
