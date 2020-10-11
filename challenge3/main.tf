provider "aws" {
  region = "eu-west-2"
}

module "ec2-db" {
  source = "./ec2"
  name   = "DB Server"
  # `null` represents absence or omission. If you set an argument of a resource or
  # module to null, Terraform behaves as though you had completely omitted it - it will
  # use the argument's default value if it has one, or raise an error if the argument
  # is mandatory
  secgroups = null
  user-data = null
}

output "db-private-ip" {
  value = module.ec2-db.private-ip
}

module "ec2-web" {
  source    = "./ec2"
  name      = "Web Server"
  secgroups = [module.sec-group.name]
  user-data = file("server-script.sh")
}

module "eip" {
  source          = "./eip"
  aws-instance-id = module.ec2-web.id
}

output "eip-public-ip" {
  value = module.eip.public-ip
}

module "sec-group" {
  source        = "./sg"
  ingress-ports = [80, 443]
  egress-ports  = [80, 443]
}
