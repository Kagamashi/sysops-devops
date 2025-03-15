'''
Python Package Index
official repository where Python packages are published and distributed

- pip install fetches packages from PyPi by default
- used to distribute open-source and propetriary Python libraries

https://pypi.org
'''

# custom packages can be published on PyPi using twine
pip install twine
twine upload dist/*
