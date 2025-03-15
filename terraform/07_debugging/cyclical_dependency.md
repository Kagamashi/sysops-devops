
## **Resolving Cyclical Dependencies**
A **cyclical dependency** occurs when two resources depend on each other, causing a Terraform error.

### **Example of Cyclic Dependency Issue**
```hcl
resource "aws_instance" "example" {
  ami           = "ami-12345678"
  instance_type = "t2.micro"
  user_data     = "${aws_security_group.example.id}"
}

resource "aws_security_group" "example" {
  name   = "example-sg"
  vpc_id = aws_instance.example.vpc_id  # Cyclical dependency!
}
```

### **How to Fix Cyclical Dependencies**
✅ **Break the Dependency:** Extract shared attributes into a separate data source or variable.
```hcl
data "aws_vpc" "existing" {
  id = "vpc-abc123"
}

resource "aws_security_group" "example" {
  vpc_id = data.aws_vpc.existing.id
  name   = "example-sg"
}
```
✅ **Use `depends_on` if necessary**, but avoid it unless required.

---
