/* 
[AVOID]

Provisioners in Terraform allow you to run scripts or commands on resources, either remotely (remote-exec) or locally (local-exec).
Use cases:
  - Installing software on a VM after it has been provisioned.
  - Running configuration scripts.
  - Bootstrapping instances with necessary configuration.
  - Executing local actions (on the machine where Terraform is run) as part of the resource creation process.

Downsides: Provisioners are not idempotent, difficult to track, and can lead to inconsistent states if they fail.
Alternatives: Use configuration management tools like Ansible || Chef || Puppet || cloud-init || managed services to avoid the complexities of provisioners. 
*/

# remote-exec is commonly used for running scripts on remote machines
resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"

  provisioner "remote-exec" {
    connection {  # defines how Terraform connects to remote machine
      type     = "ssh"
      user     = "ec2-user"
      private_key = file("~/.ssh/id_rsa")
      host     = self.public_ip
    }

    inline = [  # contains cmmands that Terraform will execute on remote machine
      "sudo apt-get update",
      "sudo apt-get install -y nginx"
      # script = "path/to/script.sh"
    ]
  }
}


# local-exec runs commands on the local machine running Terraform.
resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"

  provisioner "local-exec" {
    command = "echo 'Instance ID is ${self.id}'"  # self reference to access resource attributes
  }
}
