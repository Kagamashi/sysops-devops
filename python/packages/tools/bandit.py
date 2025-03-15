'''
Bandit (Python Security Linter)

- finds security issues in Python code (static analysis)
- detects hardcoded secrets, unsafe imports, weak cryptography
- works well with flake8 and pylint

'pip install bandit'

bandit -r my_project/

example output:
  [HIGH] Possible hardcoded password
    File: my_project/config.py
    Line: 10
    Code: SECRET_KEY = "my_secret_password"
'''
