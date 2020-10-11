provider "aws" {
  region = "eu-west-2"
}

# Module name can be anything.
module "ec2module" {
  source = "./ec2"
  # Pass values into a module
  # `ec2name` corresponds to the variable name in `ec2.tf`.
  ec2name = "Name From Module"
}

# Get the `instance_id` output from the `ec2module` module
output "module_output" {
  value = module.ec2module.instance_id
}
