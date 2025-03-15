## Python Identifiers
Python is **case-sensitive**, and identifier names follow specific conventions:

- **Class names** start with an uppercase letter. All other identifiers start with a lowercase letter.
- A **single leading underscore** (`_identifier`) indicates a **private identifier**.
- A **double leading underscore** (`__identifier`) signifies a **strongly private identifier**.
- If the identifier **ends with two trailing underscores** (`identifier__`), it is a **language-defined special name**.

---

## Reserved Words
Reserved words in Python **cannot be used as variable, constant, or function names**:

```
and      as       break    class     continue   def       del      elif     
else     except   False    finally   for        from      global   if       
import   in       is       lambda    None       nonlocal  not      or       
pass     raise    return   True      try        while     with     yield       assert
```

---

## Statements & Line Continuation
### **New Line as Statement Terminator**
- In Python, statements **typically end with a new line**.
- However, Python allows **line continuation** using the backslash (`\`).

**Example:**
```python
total = item_one + \
        item_two + \
        item_three
```

**Statements inside brackets (`[]`, `{}`, `()`), do not need line continuation:**
```python
days = ['Monday', 'Tuesday', 'Wednesday',
        'Thursday', 'Friday']
```

---

## Comments in Python
### **Single-line comment:**
```python
# This is a comment
```
### **Multi-line comment:**
```python
'''
This is a multiline comment
'''
```

---

## Multiple Statements on a Single Line
Python allows multiple statements on a **single line** using `;`:

**Example:**
```python
import sys; x = 'foo'; sys.stdout.write(x + '\n')
```
