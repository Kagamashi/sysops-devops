
## PYTHON
# Pyenv
curl https://pyenv.run

pyenv install 3.10.6
pyenv global 3.10.6
python --version

# User install: isolated environment that don't break system Python
pyenv
venv
conda

# System install:
apt
dnf
brew


## PIP
python -m ensurepip --upgrade
python get-pip.py
python -m pip install --upgrade pip


## LINTERS
# Lint (code quality)
pip install pylint flake8
pylint script.py
flake8 script.py

# Format (code style)
pip install black isort
black script.py
isort script.py
