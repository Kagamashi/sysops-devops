
'''
Singleton Pattern ensures only one instance of a struct exists.

Useful for:
- database connections
- logging systems
- configuration settings

✅ Thread-safe using sync.Once
✅ Ensures a single instance
'''

class Singleton:
    _instance = None

    def __new__(cls):
        if cls._instance is None:
            cls._instance = super().__new__(cls)
        return cls._instance

obj1 = Singleton()
obj2 = Singleton()
print(obj1 is obj2)  # Output: True (both variables reference the same instance)
