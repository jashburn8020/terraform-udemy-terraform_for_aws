provider "aws" {
  region = "eu-west-2"
}

resource "aws_instance" "ec2" {
  ami           = "ami-0a669382ea0feb73a"
  instance_type = "t2.micro"
}

resource "aws_eip" "elasticeip" {
  instance = aws_instance.ec2.id
}

output "EIP" {
  value = aws_eip.elasticeip.public_ip
}
