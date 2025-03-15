
## **Handling Complex Dependencies**
Terraform manages dependencies using **implicit and explicit dependencies**.

### **Implicit Dependencies**
Terraform automatically detects dependencies based on resource references.
```hcl
resource "aws_instance" "example" {
  vpc_security_group_ids = [aws_security_group.example.id]
}

resource "aws_security_group" "example" {
  name = "example-sg"
}
```
- Terraform knows that `aws_instance.example` depends on `aws_security_group.example` because of the reference.

### **Explicit Dependencies (`depends_on`)**
When Terraform doesn’t detect dependencies, use `depends_on` to enforce ordering.
```hcl
resource "aws_instance" "example" {
  ami           = "ami-12345678"
  instance_type = "t2.micro"
  depends_on    = [aws_security_group.example]
}
```

---
