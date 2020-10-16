provider "aws" {
  region = "eu-west-2"
}

variable "number_of_servers" {
  type = number
}

resource "aws_instance" "ec2" {
  ami           = "ami-0a669382ea0feb73a"
  instance_type = "t2.micro"
  count         = var.number_of_servers
}
