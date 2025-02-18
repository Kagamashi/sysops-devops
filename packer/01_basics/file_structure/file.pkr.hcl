packer {
  required_plugins {
    amazon = {
      version = "~> 1.0.0"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "example" {
  ami_name      = "my-custom-ami"
  instance_type = "t2.micro"
  region        = "us-east-1"
}

build {
  sources = ["source.amazon-ebs.example"]
}
