provider "aws" {
  region = "eu-west-2"
}

resource "aws_db_instance" "myRDS" {
  name           = "myDB"
  identifier     = "my-first-rds"
  instance_class = "db.t2.micro"
  engine         = "mariadb"
  engine_version = "10.2.21"
  username       = "bob"
  # Not good practice!
  password          = "password123"
  port              = 3306
  allocated_storage = 20
  # If you delete the database in the console, it's going to ask you to take a snapshot.
  # You will have the option to cancel taking the snapshot.
  # When you run `terraform destroy`, it will fail because it tries to take a snapshot
  # unless you set the following.
  skip_final_snapshot = true
}
