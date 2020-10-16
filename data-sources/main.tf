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

resource "aws_instance" "web" {
  ami           = "ami-0a669382ea0feb73a"
  instance_type = "t2.micro"
  tags = {
    Name = "Web Server"
  }

  depends_on = [aws_instance.db]
}

# Apply the above first before entering the following.

# Query AWS for any instance that has the tag `DB Server`
data "aws_instance" "dbsearch" {
  filter {
    # The key we are searching for is a tag with the word `Name`.
    name   = "tag:Name"
    values = ["DB Server"]
  }
}

output "dbservers" {
  # data.aws_instance.<data name>.<attribute>
  value = data.aws_instance.dbsearch.availability_zone
}
