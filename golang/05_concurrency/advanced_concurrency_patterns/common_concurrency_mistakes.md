# Common Concurrency Mistakes in Go

## 1. Goroutine Leaks

### What is it?
Goroutines that are started but never terminate, leading to increased memory consumption.

### Why does it happen?
- The goroutine is waiting on a channel that no longer has a sender.
- The goroutine was never properly stopped.

### Example: Goroutine Leak
```go
func leakyGoroutine() {
	ch := make(chan int)
	go func() {
		for val := range ch { // Blocks forever if ch is never closed
			fmt.Println(val)
		}
	}()
}

func main() {
	leakyGoroutine()
	time.Sleep(time.Second) // The goroutine is still running
}
```

### Fix: Use Context for Proper Termination
```go
func safeGoroutine(ctx context.Context) {
	ch := make(chan int)
	go func() {
		defer close(ch)
		for {
			select {
			case val := <-ch:
				fmt.Println(val)
			case <-ctx.Done(): // Gracefully exit on context cancellation
				fmt.Println("Goroutine stopped")
				return
			}
		}
	}()
}

func main() {
	ctx, cancel := context.WithTimeout(context.Background(), time.Second)
	defer cancel()
	safeGoroutine(ctx)
	time.Sleep(2 * time.Second)
}
```

---

## 2. Data Races

### What is it?
When multiple goroutines access and modify the same variable without proper synchronization.

### Why does it happen?
- No locks or atomic operations to ensure safe concurrent access.

### Example: Race Condition
```go
var counter int

func raceCondition() {
	for i := 0; i < 1000; i++ {
		go func() { counter++ }() // Multiple goroutines modifying counter concurrently
	}
	time.Sleep(time.Second)
	fmt.Println("Counter:", counter) // Unpredictable output
}
```

### Fix: Use `sync.Mutex`
```go
var counter int64
var mu sync.Mutex

func safeCounter() {
	for i := 0; i < 1000; i++ {
		go func() {
			mu.Lock()
			counter++
			mu.Unlock()
		}()
	}
	time.Sleep(time.Second)
	fmt.Println("Counter:", counter) // Predictable output
}
```

### Alternatively, Use Atomic Operations
```go
var counter int64

func atomicCounter() {
	for i := 0; i < 1000; i++ {
		go func() {
			atomic.AddInt64(&counter, 1)
		}()
	}
	time.Sleep(time.Second)
	fmt.Println("Counter:", counter)
}
```

---

## 3. Deadlocks

### What is it?
Two or more goroutines are waiting for each other, causing a circular wait.

### Why does it happen?
- Holding locks in the wrong order.
- Waiting on channels incorrectly.

### Example: Deadlock
```go
var mu1, mu2 sync.Mutex

func deadlock() {
	go func() {
		mu1.Lock()
		time.Sleep(100 * time.Millisecond) // Simulate some work
		mu2.Lock() // Waiting for mu2
		mu2.Unlock()
		mu1.Unlock()
	}()

	go func() {
		mu2.Lock()
		time.Sleep(100 * time.Millisecond)
		mu1.Lock() // Waiting for mu1, causing deadlock
		mu1.Unlock()
		mu2.Unlock()
	}()

	time.Sleep(time.Second)
	fmt.Println("Finished (if no deadlock)")
}
```

### Fix: Locking Order & `sync.TryLock`
- Always lock and unlock in a **consistent order**.
- Use `sync.TryLock` to avoid waiting indefinitely.

---

## 4. Blocking Operations in Goroutines

### What is it?
A goroutine blocks indefinitely, preventing further progress.

### Why does it happen?
- Waiting on a channel that is never closed or has no sender.

### Example: Blocked Goroutine
```go
func blockedGoroutine() {
	ch := make(chan int)
	go func() {
		fmt.Println("Waiting for input...")
		fmt.Println(<-ch) // Blocks forever if no sender
	}()
	time.Sleep(time.Second)
}
```

### Fix: Use Timeouts or Context Cancellation
```go
func nonBlockingGoroutine() {
	ch := make(chan int)
	ctx, cancel := context.WithTimeout(context.Background(), time.Second)
	defer cancel()

	go func() {
		select {
		case val := <-ch:
			fmt.Println(val)
		case <-ctx.Done():
			fmt.Println("Operation timed out")
		}
	}()
	time.Sleep(2 * time.Second)
}
```

---
