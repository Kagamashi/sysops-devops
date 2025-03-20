package main

import (
	b64 "encoding/base64" // This syntax imports encoding/base64 package with b64 name instead of default base64
	"fmt"
)

/* BASE64 ENCODING
encoding/base64 package provides functions to encode/decode data in Base64, commonly used encoding scheme for safely transmitting binary data as text

base64.StdEncoding.EncodeToString(data []byte) - encodes byte data into Base64 string
base64.StgEncoding.DecodeString(encoded string) - decoded Base64 string back into original byte slice
base64.URLEncoding - encoding URL-safe Base54 by using - and _ instead of + and /

- Safely transmitting binary data (images, files..) in text formats like JSON or URLs
- Encoding cryptographic keys, token, other binary data in human-readable format
*/

func base64_encoding() {

	data := "abc123!?$*&()'-=@~"

	sEnc := b64.StdEncoding.EncodeToString([]byte(data))
	fmt.Println(sEnc)
	// YWJjMTIzIT8kKiYoKSctPUB+

	sDec, _ := b64.StdEncoding.DecodeString(sEnc)
	fmt.Println(string(sDec))
	// abc123!?$*&()'-=@~
	fmt.Println()

	uEnc := b64.URLEncoding.EncodeToString([]byte(data))
	fmt.Println(uEnc)
	// YWJjMTIzIT8kKiYoKSctPUB-
	uDec, _ := b64.URLEncoding.DecodeString(uEnc)
	fmt.Println(string(uDec))
	// abc123!?$*&()'-=@~

}
