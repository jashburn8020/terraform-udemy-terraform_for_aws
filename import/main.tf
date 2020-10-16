provider "aws" {
  region = "eu-west-2"
}

resource "aws_vpc" "myvpc" {
  cidr_block = "10.0.0.0/16"
}

# Run `terraform apply` before entering the following.

resource "aws_vpc" "myvpc2" {
  cidr_block = "192.168.0.0/24"
}

# Set up a VPC using AWS Console, matching `myvpc2` above. Copy the VPC ID.
# `terraform import aws_vpc.myvpc2 <vpc_id>`
