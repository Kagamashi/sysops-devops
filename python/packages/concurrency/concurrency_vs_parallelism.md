## **Threading, Multiprocessing & GIL Considerations**
Python has a **Global Interpreter Lock (GIL)**, which restricts execution to **one thread at a time**, limiting true parallel execution for CPU-bound tasks.

| **Technique** | **Best For** | **Uses Multiple CPU Cores?** | **GIL Bypassed?** |
|--------------|-------------|-----------------|--------------|
| **Threading** | I/O-bound tasks (networking, file I/O) | ❌ No | ❌ No |
| **Multiprocessing** | CPU-bound tasks (heavy computation) | ✅ Yes | ✅ Yes |
| **Asyncio** | High-concurrency I/O tasks | ❌ No | ✅ Yes (via async I/O) |

---

## **`threading` (concurrency, not true parallelism)**
✔ **Best for I/O-bound tasks** (e.g., downloading files, making API calls).  
✔ **Multiple threads run concurrently but share the same memory (GIL restricts parallel execution).**

### **Example: Multithreading**
```python
import threading
import time

def task(name):
    print(f"Starting {name}")
    time.sleep(2)  # Simulates I/O operation
    print(f"Finished {name}")

# Creating multiple threads
thread1 = threading.Thread(target=task, args=("Thread-1",))
thread2 = threading.Thread(target=task, args=("Thread-2",))

thread1.start()
thread2.start()

thread1.join()
thread2.join()

print("All threads completed!")
```
**Output:**
```
Starting Thread-1
Starting Thread-2
Finished Thread-1
Finished Thread-2
All threads completed!
```
🔹 Threads **run concurrently but do not bypass the GIL**.

---

## **`multiprocessing` (true parallelism)**
✔ **Best for CPU-bound tasks** (e.g., image processing, machine learning).  
✔ **Each process runs in a separate Python interpreter, bypassing the GIL.**

### **Example: Multiprocessing**
```python
import multiprocessing
import time

def task(name):
    print(f"Starting {name}")
    time.sleep(2)
    print(f"Finished {name}")

# Creating multiple processes
if __name__ == "__main__":
    process1 = multiprocessing.Process(target=task, args=("Process-1",))
    process2 = multiprocessing.Process(target=task, args=("Process-2",))

    process1.start()
    process2.start()

    process1.join()
    process2.join()

    print("All processes completed!")
```
🔹 **True parallelism**: Both processes run on different CPU cores.

---

## **`asyncio` (asynchronous I/O)**
✔ **Best for I/O-bound tasks that involve waiting (e.g., network requests, DB queries).**  
✔ **Uses an event loop and coroutines to efficiently handle multiple tasks.**  
✔ **Non-blocking execution → No waiting for slow I/O operations.**

### **Example: Asyncio with Coroutines**
```python
import asyncio

async def task(name):
    print(f"Starting {name}")
    await asyncio.sleep(2)  # Non-blocking wait
    print(f"Finished {name}")

async def main():
    await asyncio.gather(task("Task-1"), task("Task-2"))

asyncio.run(main())
```
🔹 Unlike **threads**, `asyncio` **does not use multiple CPU cores** but handles multiple I/O tasks **concurrently**.

---

## **Concurrency vs. Parallelism**
### **✔ Concurrency (`threading`, `asyncio`)**
- **Best for**: I/O-bound tasks (e.g., web scraping, network requests, DB queries).
- **Why?**: These tasks spend most of their time **waiting** rather than using the CPU.

### **✔ Parallelism (`multiprocessing`)**
- **Best for**: CPU-bound tasks (e.g., data processing, video encoding).
- **Why?**: These tasks need **actual CPU time**, so multiple cores improve performance.

---
