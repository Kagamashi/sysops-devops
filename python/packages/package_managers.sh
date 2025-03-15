'''
tool that automates installation, upgrade, configuration and management of third-party libraries and depencies
- allows installation of external Python libraries
- manages dependencies (ensures correct version of packages)
- helps in creating isolated environments (virtual environments)
'''

## pip (default, most common)
# Python Installation Program
pip --version

python -m ensurepip --default-pip

pip install requests
pip install requests==2.28.0
pip install --upgrade requests

pip list
pip uninstall requests

pip install -r requirements.txt # install multiple dependcies at once
pip freeze > requirements.txt # generate a requirements.txt


## conda (manages python packages and system dependencies - data science)
conda install numpy
conda install numpy=1.21
conda list
conda remove numpy
conda env create -f environment.yml # conda uses environment.yml for dependencies


## poetry (project management)
pip install poetry

poetry new my_project
cd my_project
poetry add requests
poetry run python script.py
poetry lock # lock dependecies - pyproject.toml


## pipenv (combines pip and virtualenv - web development)
pip install pipenv
pipenv install requests

pipenv shell
pipenv install # install all dependecies from Pipfile.lock


## uv (very fast)
pip install uv
uv venv create  # Create a virtual environment
uv pip install requests  # Install packages like pip
uv pip freeze > requirements.txt  # Save dependencies
