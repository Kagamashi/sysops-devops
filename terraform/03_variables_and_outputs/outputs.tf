
# modules/network/outputs.tf
output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.example.id
}

# Terraform allows modules to export outputs so they can be used in other parts of the configuration

# network.tf
module "network" {
  source = "./modules/network"
}

output "network_vpc_id" {
  value = module.network.vpc_id
}

resource "aws_subnet" "example" {
  vpc_id = module.network.vpc_id
  cidr_block = "10.0.1.0/24"
}
