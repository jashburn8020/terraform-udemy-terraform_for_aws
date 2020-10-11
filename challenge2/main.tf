provider "aws" {
  region = "eu-west-2"
}

resource "aws_instance" "db" {
  ami           = "ami-0a669382ea0feb73a"
  instance_type = "t2.micro"
  tags = {
    Name = "DB Server"
  }
}

output "PrivateIP" {
  value = aws_instance.db.private_ip
}

resource "aws_instance" "web" {
  ami             = "ami-0a669382ea0feb73a"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.web-traffic.name]
  # `file` reads the content of the script and pass it on to `user_data`.
  # https://www.terraform.io/docs/configuration/functions/file.html
  user_data = file("server-script.sh")
  tags = {
    Name = "Web Server"
  }
}

resource "aws_eip" "web-ip" {
  instance = aws_instance.web.id
}

output "PublicIP" {
  value = aws_eip.web-ip.public_ip
}

variable "ingress" {
  type    = list(number)
  default = [80, 443]
}

variable "egress" {
  type    = list(number)
  default = [80, 443]
}

resource "aws_security_group" "web-traffic" {
  name = "Allow HTTP and HTTPS"

  dynamic "ingress" {
    iterator = port
    for_each = var.ingress
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  dynamic "egress" {
    iterator = port
    for_each = var.egress
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}
