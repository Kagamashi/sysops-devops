'''
python-terraform is used to interact with Terraform CLI inside python scripts

'pip install python-terraform'
'''

from python_terraform import Terraform # type: ignore

tf = Terraform(working_dir="./terraform")
tf.init()
tf.apply(skip_plan=True)
