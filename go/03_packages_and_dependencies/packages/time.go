package main
import (
	"fmt"
	"time"
)

/* TIME
time package in Go provides functions to work with date and time, including getting the current time, formatting, and time arithmetic

time.Now() - returns current local time
time.Add(d time.Duration) - adds duration to a time.Time value
time.Sub(t) - computes the duration between two time.Time values
time.Sleep(d time.Duration) - pauses execution for a specified duration
*/

func time_def() {
	p := fmt.Println

	now := time.Now()
	p(now)
	// 2024-09-14 21:47:57.504068 +0200 CEST m=+0.000124335

	then := time.Date(
		2009, 11, 17, 20, 34, 58, 651387237, time.UTC)
	p(then)
	// 2009-11-17 20:34:58.651387237 +0000 UTC

	p(then.Year())       // 2009
	p(then.Month())      // November
	p(then.Day())        // 17
	p(then.Hour())       // 20
	p(then.Minute())     // 34
	p(then.Second())     // 58
	p(then.Nanosecond()) // 651387237
	p(then.Location())   // UTC

	p(then.Weekday()) // Tuesday

	p(then.Before(now)) // true
	p(then.After(now))  // false
	p(then.Equal(now))  // false

	diff := now.Sub(then)
	p(diff)
	// 129959h12m58.852680763s

	p(diff.Hours())       // 129959.21634796688
	p(diff.Minutes())     // 7.797552980878012e+06
	p(diff.Seconds())     // 4.6785317885268074e+08
	p(diff.Nanoseconds()) // 467853178852680763

	p(then.Add(diff))  // 2024-09-14 19:47:57.504068 +0000 UTC
	p(then.Add(-diff)) // 1995-01-20 21:21:59.798706474 +0000 UTC
}



/* TIME FORMATTING
time package in Go allows formatting and parsing of time values into different string representartions and vice versa
- Go unique reference layout to format time:
Mon Jan 2 15:04:05 MST 2006
- Common Layouts:
2006-01-02 : YYYY-MM-DD (data format)
15:04:05 : HH:MM (24-hour time)
Mon, 02 Jan 2006 15:04:05 MST : full timestamp with day and timezone

- time.Format(layout string) - formats time.Time value into a string according to specified layout
now := time.Now()
formatted := now.Format("2006-01-02 15:04:05") // Format as "YYYY-MM-DD HH:MM:SS"
fmt.Println("Formatted time:", formatted)

- time.Parse(layout, value) - parses a string into a time.Time value based on layout
layout := "2006-01-02"
t, err := time.Parse(layout, "2024-09-12")
if err == nil {
    fmt.Println("Parsed time:", t)
}
*/

func time_formatting() {
	p := fmt.Println

	t := time.Now()
	p(t.Format(time.RFC3339)) // Format time according to RFC3339 (ISO 8601 standard)
	// 2024-09-14T21:58:26+02:00

	t1, e := time.Parse(
		time.RFC3339,
		"2012-11-01T22:08:41+00:00")
	p(t1)
	// 2012-11-01 22:08:41 +0000 +0000

	p(t.Format("3:04PM")) // Format current time as 12-hour clock with AM/PM notation
	// 9:58PM

	p(t.Format("Mon Jan _2 15:04:05 2006")) // Format current time in more human-readable format
	// Sat Sep 14 21:58:26 2024

	p(t.Format("2006-01-02T15:04:05.999999-07:00"))
	// 2024-09-14T21:58:26.704653+02:00

	form := "3 04 PM"
	t2, e := time.Parse(form, "8 41 PM") // Define custom time format and parse a string using that format
	p(t2)
	// 0000-01-01 20:41:00 +0000 UTC

	fmt.Printf("%d-%02d-%02dT%02d:%02d:%02d-00:00\n",
		t.Year(), t.Month(), t.Day(),
		t.Hour(), t.Minute(), t.Second())
	// 2024-09-14T21:58:26-00:00

	ansic := "Mon Jan _2 15:04:05 2006"
	_, e = time.Parse(ansic, "8:41PM")
	p(e)
	// parsing time "8:41PM" as "Mon Jan _2 15:04:05 2006": cannot parse "8:41PM" as "Mon"
}



/* TIMERS
Fire once after a delay.

- Creating a timer
timer := time.NewTimer(2 * time.Second)
- Receiving from timer
<-timer.C
- time.After shortcut returns a channel that sends the current time after a duration (timeouts)
<-time.After(2 * time.Second)
- Stopping a timer
timer.Stop()
*/

func timers() {

	timer1 := time.NewTimer(2 * time.Second) // timers represent a single event in the future
	// we tell the timer how long we want to wait, and it provides a channel that will be notified at that time

	<-timer1.C // <-timer1.C blocks on the timer's channel C until it sends a value indicating that the timer fired
	fmt.Println("Timer 1 fired")

	timer2 := time.NewTimer(time.Second) // if we just want to wait we can use time.Sleep
	go func() {                          //t timer can be useful because it can be canceled before it fires
		<-timer2.C
		fmt.Println("Timer 2 fired")
	}()
	stop2 := timer2.Stop()
	if stop2 {
		fmt.Println("Timer 2 stopped")
	}

	time.Sleep(2 * time.Second) // give the timer2 enough time to fire, if it ever was going to show it is in fact stopped
	// Timer 1 fired
	// Timer 2 stopped

	/*
		The first timer will fire 2s after we start the program,
		but the second should be stopeed before it has a chance to fire.
	*/
}



/* TICKERS
Trigger events at regular intervals.

- Creating ticker
ticker := time.NewTicker(500 * time.Millisecond)
- Receiving from a ticker
for t := range ticker.C {
	fmt.Println("Tick at", t)
}
- Stopping a ticker
ticker.Stop()
*/

func tickers() {

	ticker := time.NewTicker(500 * time.Millisecond) // tickers use simillar mechanism to timers
	done := make(chan bool)                          // a channel that is sent values

	go func() {
		for {
			select { // we use select on the channel to await the values as they arrive every 500ms
			case <-done:
				return
			case t := <-ticker.C:
				fmt.Println("Tick at", t)
			}
		}
	}()

	time.Sleep(1600 * time.Millisecond) //tickers can be stopped like timers
	ticker.Stop()                       // once a ticker is stopped it won't receive any more valiues on its channel
	done <- true
	fmt.Println("Ticker stopped")
	// Tick at 2012-09-23 11:29:56.487625 -0700 PDT
	// Tick at 2012-09-23 11:29:56.988063 -0700 PDT
	// Tick at 2012-09-23 11:29:57.488076 -0700 PDT
	// Ticker stopped

	/* When we run the program the ticker should tick 3 times before we stop it */
}



/* EPOCH
Unix epoch (1 January 1970) is used as a reference point for representing time as an integer (seconds or milliseconds since the epoch)
time.Now().Unix() - returns current Unix time in seconds
time.Now().UnixMilli() - returns current Unix time in Milliseconds

- Converting Epoch to time.Time:
time.Unix(seconds, nanoseconds)
- Useful for working with timestamps in systems that store time as Unix timestamps (databases, APIs)
*/

func epoch_def() {

	now := time.Now()
	fmt.Println(now)
	// 2024-09-14 21:49:30.421022 +0200 CEST m=+0.000124460

	fmt.Println(now.Unix())      // 1726343370
	fmt.Println(now.UnixMilli()) // 1726343370421
	fmt.Println(now.UnixNano())  // 1726343370421022000

	// Converting integer seconds/nanoseconds since the epoch into corresponding time
	fmt.Println(time.Unix(now.Unix(), 0))     // 2024-09-14 21:49:30 +0200 CEST
	fmt.Println(time.Unix(0, now.UnixNano())) // 2024-09-14 21:49:30.421022 +0200 CEST
}
