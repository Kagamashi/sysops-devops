'''
YAML File Handling

pip install pyyaml
'''

import yaml # type: ignore

data, stream = ""

yaml.dump(data, stream)     # Convert Python object to YAML string
yaml.safe_load(stream)      # Convert YAML string to Python object with safe defaults   

data = {'name': 'Alice', 'age': 30}

# Writing to YAML file
with open("data.yaml", "w") as f:
    yaml.dump(data, f)

# Reading from YAML file
with open("data.yaml", "r") as f:
    loaded_data = yaml.safe_load(f)

print(loaded_data)  # Output: {'name': 'Alice', 'age': 30}
