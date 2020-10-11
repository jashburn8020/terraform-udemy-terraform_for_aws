# Use variables to pass data into a module.
variable "ec2name" {
  type = string
}

resource "aws_instance" "ec2" {
  ami           = "ami-0a669382ea0feb73a"
  instance_type = "t2.micro"
  tags = {
    # Use data passed into this module.
    Name = var.ec2name
  }
}

# Output the `ec2` resource ID.
output "instance_id" {
  value = aws_instance.ec2.id
}
