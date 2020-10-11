variable "aws-instance-id" {
  type = string
}

resource "aws_eip" "web-ip" {
  instance = var.aws-instance-id
}

output "public-ip" {
  value = aws_eip.web-ip.public_ip
}
