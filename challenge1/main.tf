provider "aws" {
  region = "eu-west-2"
}

# Create a resource, an AWS VPC.
# "myvpc" is an internal name.
resource "aws_vpc" "challenge1vpc" {
  cidr_block = "192.168.0.0/24"
  tags = {
    Name = "TerraformVPC"
  }
}
