provider "aws" {
  region = "eu-west-2"
}

# DB server needs to come up first before the web server.
resource "aws_instance" "db" {
  ami           = "ami-0a669382ea0feb73a"
  instance_type = "t2.micro"
}

# `web` depends on `db`.
resource "aws_instance" "web" {
  ami           = "ami-0a669382ea0feb73a"
  instance_type = "t2.micro"

  depends_on = [aws_instance.db]
}
