variable "server_names" {
  type = list(string)
}

resource "aws_instance" "ec2" {
  ami           = "ami-0a669382ea0feb73a"
  instance_type = "t2.micro"
  count         = length(var.server_names)
  tags = {
    Name = var.server_names[count.index]
  }
}

output "private-ip" {
  value = [aws_instance.ec2.*.private_ip]
}
