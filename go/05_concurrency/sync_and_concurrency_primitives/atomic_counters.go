package main
import (
	"fmt"
	"sync"
	"sync/atomic"
)

/*
Atomic Counters allow safe manipulation of shared variables across multiple goroutines without explicit locks, avoiding race conditions.
- Using sync/atomic package provides atomic operations like: Add, Load, Store, CompareAndSwap on integers and pointers
- Incrementing an Atomic Counter:
	var counter int64
	atomic.AddInt64(&counter, 1)

- Reading an Atomic Counter:
	val := atomic.LoadInt64(&counter)

- Atomic functions ensure that incrementing, reading or updating a variable happens without interference from other goroutines
- Efficient and lock-free way to manage shared counters across multiple goroutines

atomic.AddInt64(&val, n)	atomically adds n to val
atomic.LoadInt64(&val)		atomically reads val
atomic.StoreInt64(&val, n)	atomically sets val to n
atomic.CompareAndSwapInt64(&val, old, new)		sets val to new if val == old
*/

func atomic_counters() {

	var ops atomic.Uint64 //atomic integer type to represent (always-positive) counter (goroutines can modify it without conflict)

	var wg sync.WaitGroup // WaitGroup will help us wait for all goroutines to finish their work

	for i := 0; i < 50; i++ { // Start 50 goroutines that each increment the counter exactly 1000 times
		wg.Add(1) // Raise WaitGroup counter by 1 for each goroutine started

		go func() {
			for c := 0; c < 1000; c++ { // 1000 operations incrementing opc counter by 1

				ops.Add(1) // To atomically increment the counter we use Add
			}

			wg.Done() // Reduce WaitGroup couter signalizing that goroutine ended its work
		}()
	}

	wg.Wait() //Wait until all goroutines are done = all goroutines do wg.Done()

	fmt.Println("ops:", ops.Load()) //using Load its safe to atomically read a value even while other goroutines are (atomically) updating it
	// ops: 50000

	/* We expect to get exactly 50000 operations
	If we have used non-atomic integer and incremented it with ops++ we would get a different number,
	that would change between runs because goroutines would interfere with each other.

	Moreover, we'd get data race failures when running with the -race flag.  */

}