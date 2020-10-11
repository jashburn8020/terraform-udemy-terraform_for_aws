variable "name" {
  type = string
}

variable "secgroups" {
  type = list(string)
}

variable "user-data" {
  type = string
}

resource "aws_instance" "ec2" {
  ami             = "ami-0a669382ea0feb73a"
  instance_type   = "t2.micro"
  security_groups = var.secgroups
  user_data       = var.user-data
  tags = {
    Name = var.name
  }
}

output "private-ip" {
  value = aws_instance.ec2.private_ip
}

output "id" {
  value = aws_instance.ec2.id
}
