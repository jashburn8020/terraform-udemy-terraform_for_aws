provider "aws" {
  region = "eu-west-2"
}

# "vpcname" is the label we will use to access the variable.
variable "vpcname" {
  type    = string
  default = "myvpc"
}

variable "sshport" {
  type    = number
  default = 22
}

variable "enabled" {
  default = true
}

# List index starts with 0.
variable "mylist" {
  type    = list(string)
  default = ["Value1", "Value2"]
}

variable "mymap" {
  type = map
  default = {
    Key1 = "Value1"
    Key2 = "Value2"
  }
}

variable "inputname" {
  type        = string
  description = "Set the name of the VPC"
}

# Using variables
resource "aws_vpc" "myvpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    # Name = var.vpcname
    # Name = var.mylist[0]
    # Name = var.mymap["Key1"]
    Name = var.inputname
  }
}

output "vpcid" {
  # See https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc#id
  # for other attributes.
  # value = resource_type.name.attribute
  value = aws_vpc.myvpc.id
}

variable "mytuple" {
  type    = tuple([string, number, string])
  default = ["cat", 1, "dog"]
}

variable "myobject" {
  type = object({ name = string, port = list(number) })
  default = {
    name = "TJ"
    port = [22, 25, 80]
  }
}
