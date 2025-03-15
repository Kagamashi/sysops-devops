
# executes the changes defined in the execution plan to reach the desired state

terraform apply

-auto-approve   # skips approval prompt
-var key=value  # sets a variable
-planfile       # apply previously saved plan file
-var-file=vars.tfvars
-target         # applies only specifc resource
