'''
[asynchronous I/O]

Asynchronous programming allows to handle multiple tasks concurrently without waiting for one to complete before moving to the next.
It is particularly used for I/O-bound tasks, like reading from files, network requests or database queries where waiting is involved

asyncio module:
  async def: Defines an asynchronous function.
  await: Pauses the execution of the coroutine until the awaited task is completed.
  asyncio.run(): Runs the main asynchronous function.
  asyncio.create_task(): Schedules an asynchronous task concurrently.

Coroutines (async def) are special functions that can be paused and resumed later, making asynchronous programming more efficient.
await is used to call another coroutine and wait for it to finish without blocking the main program.
asyncio is best suited for I/O-bound tasks like network operations or file I/O.
'''

import asyncio

async def print_numbers():
    for i in range(5):
        await asyncio.sleep(1)
        print(i)

async def main():
    # Running tasks concurrently
    task1 = asyncio.create_task(print_numbers())
    task2 = asyncio.create_task(print_numbers())

    await task1
    await task2

# Running the main async function
asyncio.run(main())
