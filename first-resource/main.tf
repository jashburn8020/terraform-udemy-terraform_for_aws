# Tells Terraform which plugin to use, and for which cloud platform for which to create
# resources.
provider "aws" {
  region = "eu-west-2"
}

# Create a resource, an AWS VPC.
# "myvpc" is an internal name.
resource "aws_vpc" "myvpc" {
  cidr_block = "10.0.0.0/16"
}
