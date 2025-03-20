package main
import (
	"fmt"
	"time"
)

/*
Rate Limiting controles the frequency of events or requests, often used in APIs to limit traffic.
- Implemented by using:
	time.Ticker
	time.Sleep
- Go supports rate limiting with goroutines, channels, tickers.
- Token Bucket Pattern - common pattern where a fixed number of tokens are replenished over time to allow a limited number of operations
- Basic example with Ticker:
	limiter := time.NewTicker(200 * time.Millisecond)
	for req := range requests {
		<-limiter.C // Throttle by waiting for the ticker
		// Process request
	}

- Bursty Rate Limiting using a buffered channel to allow short burts of requests, then limit:
	burstLimiter := make(chan time.Time, 3)
	for i := 0; i < 3; i++ {
		burstLimiter <- time.Now()
	}
	go func() {
		for t := range time.NewTicker(200 * time.Millisecond).C {
			burstLimiter <- t
		}
	}()

- Prevents system overload by controlling request rates
*/

func rate_limiting() {

	requests := make(chan int, 5) //basic rate limiting
	for i := 1; i <= 5; i++ {
		requests <- i
	}
	close(requests)

	limiter := time.Tick(200 * time.Millisecond) //limiter channel receive a value every 200ms - works as regulator in this scheme

	for req := range requests { // by blocking on a receive from the limiter channel before serving each request, we limit ourselves to 1 request every 200ms
		<-limiter
		fmt.Println("request", req, time.Now())
	}

	burstyLimiter := make(chan time.Time, 3) // we want to allow short bursts of requests in our rate limiting scheme while preserving the overall rate limit
	// we can accomplish this by buffering our limiter channel - allowing up to 3 events

	for i := 0; i < 3; i++ { //fill up the channel to represent allowed bursting
		burstyLimiter <- time.Now()
	}

	go func() { //every 200ms we'll try to add a new value to burstyLimiter, up to its limit of 3
		for t := range time.Tick(200 * time.Millisecond) {
			burstyLimiter <- t
		}
	}()

	burstyRequests := make(chan int, 5) //now simulate 5 more incoming requests - the first 3 of these will benefit from the burst capability of burstyLimiter
	for i := 1; i <= 5; i++ {
		burstyRequests <- i
	}
	close(burstyRequests)
	for req := range burstyRequests {
		<-burstyLimiter
		fmt.Println("request", req, time.Now())
	}

	/*
		request 1 2024-09-10 21:49:53.123106 +0200 CEST m=+0.201284667
		request 2 2024-09-10 21:49:53.322339 +0200 CEST m=+0.400525001
		request 3 2024-09-10 21:49:53.523104 +0200 CEST m=+0.601298501
		request 4 2024-09-10 21:49:53.723129 +0200 CEST m=+0.801331584
		request 5 2024-09-10 21:49:53.923107 +0200 CEST m=+1.001316792

		request 1 2024-09-10 21:49:53.923403 +0200 CEST m=+1.001612959
		request 2 2024-09-10 21:49:53.923423 +0200 CEST m=+1.001633209
		request 3 2024-09-10 21:49:53.923432 +0200 CEST m=+1.001642501
		request 4 2024-09-10 21:49:54.124482 +0200 CEST m=+1.202700667
		request 5 2024-09-10 21:49:54.324379 +0200 CEST m=+1.402605376
	*/

	// runnin the program we see the first batch of requests handled once every 200ms as desired
	// for the second batch of requests we serve the first 3 immediately because of the burstable rate limiting, then the remaining 2 are served with 200ms delays each
}
