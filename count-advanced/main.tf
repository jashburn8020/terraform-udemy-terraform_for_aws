provider "aws" {
  region = "eu-west-2"
}

# Terraform 0.13 has a version of `count` for modules.
# Below is a workaround for Terraform 0.12.
module "ec2" {
  source       = "./ec2"
  server_names = ["server_1", "server_2", "server_3"]
}

# The output can be handed over to another tool like Ansible for further configuration.
output "private_ips" {
  value = module.ec2.private-ip
}
