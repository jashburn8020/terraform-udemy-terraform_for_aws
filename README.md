# Terraform for AWS - Beginner to Expert 2020 (0.12)

Notes and examples from the Terraform for AWS course in Udemy

- [Terraform for AWS - Beginner to Expert 2020 (0.12)](#terraform-for-aws---beginner-to-expert-2020-012)
  - [Initial Setup](#initial-setup)
    - [VS Code](#vs-code)
    - [Terraform Installation](#terraform-installation)
    - [AWS Setup](#aws-setup)
  - [Terraform 101](#terraform-101)
    - [Variables 101](#variables-101)
  - [EC2](#ec2)
    - [Elastic IP](#elastic-ip)
    - [Security Group](#security-group)
    - [Dynamic Blocks](#dynamic-blocks)
    - [Challenge 2](#challenge-2)
  - [Other Resources](#other-resources)

## Initial Setup

### VS Code

- Install the HashiCorp Terraform extension

### Terraform Installation

- Download Terraform from <https://www.terraform.io/downloads.html>
- Add the `terraform` binary to the `PATH`
- Alternatively, use [tfswitch](https://tfswitch.warrensbox.com/) to manage Terraform installations and versions
- Enable tab completion on bash or zsh
  - `terraform -install-autocomplete`
  - restart shell

### AWS Setup

- Create an IAM user
  - user name: e.g., `terraform_udemy`
  - access type: `Programmatic access`
  - permissions:
    - `Attach existing policies directly`
    - _can be more granular, but not straightforward_:
      - [What's the most efficient way to determine the minimum AWS permissions necessary for a Terraform configuration?](https://stackoverflow.com/questions/51273227/whats-the-most-efficient-way-to-determine-the-minimum-aws-permissions-necessary)
      - [Determining a minimal IAM policy required to perform a terraform run](https://github.com/hashicorp/terraform/issues/2834)
  - tags: skip
  - review: `Create user`
- Copy IAM user access key ID and secret access key or download the CSV file
- _Delete user when done with the course_
- Secure access credentials using AWS CLI
  - 3 ways: set as environment variables, use AWS CLI, use Terraform Vault Provider
  - AWS CLI stores credentials in a `.aws` directory in your home directory
    - install AWS CLI: <https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html>
      - installing without `sudo`: `./install -i ~/devel/aws-cli -b ~/bin`
    - `aws configure`
      - specify the access key ID and secret access key when prompted
      - default region name: choose from <https://docs.aws.amazon.com/general/latest/gr/rande.html>, e.g., `eu-west-2`
      - default output format: `json`

## Terraform 101

- Create [`first-resource/main.tf`](first-resource/main.tf)
- Initialise the `first-resource` directory
  - go to the `first-resource` directory
  - `terraform init`

```console
$ terraform init

Initializing the backend...

Initializing provider plugins...
- Finding latest version of hashicorp/aws...
- Installing hashicorp/aws v3.10.0...
- Installed hashicorp/aws v3.10.0 (signed by HashiCorp)

The following providers do not have any version constraints in configuration,
so the latest version was installed.

To prevent automatic upgrades to new major versions that may contain breaking
changes, we recommend adding version constraints in a required_providers block
in your configuration, with the constraint strings suggested below.

* hashicorp/aws: version = "~> 3.10.0"

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```

- Create an execution plan: `terraform plan`
  - check state
  - tells Terraform what it has already created and what it needs to create
  - `known after apply` are computed values

```console
$ terraform plan
Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.


------------------------------------------------------------------------

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_vpc.myvpc will be created
  + resource "aws_vpc" "myvpc" {
      + arn                              = (known after apply)
      + assign_generated_ipv6_cidr_block = false
      + cidr_block                       = "10.0.0.0/16"
      + default_network_acl_id           = (known after apply)
      + default_route_table_id           = (known after apply)
      + default_security_group_id        = (known after apply)
      + dhcp_options_id                  = (known after apply)
      + enable_classiclink               = (known after apply)
      + enable_classiclink_dns_support   = (known after apply)
      + enable_dns_hostnames             = (known after apply)
      + enable_dns_support               = true
      + id                               = (known after apply)
      + instance_tenancy                 = "default"
      + ipv6_association_id              = (known after apply)
      + ipv6_cidr_block                  = (known after apply)
      + main_route_table_id              = (known after apply)
      + owner_id                         = (known after apply)
    }

Plan: 1 to add, 0 to change, 0 to destroy.

------------------------------------------------------------------------

Note: You didn't specify an "-out" parameter to save this plan, so Terraform
can't guarantee that exactly these actions will be performed if
"terraform apply" is subsequently run.
```

- Apply changes: `terraform apply`
  - VPC (resource) `vpc-0dc84c1c7f8c0cdf7` created in the `eu-west-2` region
  - <https://eu-west-2.console.aws.amazon.com/vpc/home?region=eu-west-2#vpcs:>

```console
$ terraform apply

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_vpc.myvpc will be created
  + resource "aws_vpc" "myvpc" {
      + arn                              = (known after apply)
      + assign_generated_ipv6_cidr_block = false
      + cidr_block                       = "10.0.0.0/16"
      + default_network_acl_id           = (known after apply)
      + default_route_table_id           = (known after apply)
      + default_security_group_id        = (known after apply)
      + dhcp_options_id                  = (known after apply)
      + enable_classiclink               = (known after apply)
      + enable_classiclink_dns_support   = (known after apply)
      + enable_dns_hostnames             = (known after apply)
      + enable_dns_support               = true
      + id                               = (known after apply)
      + instance_tenancy                 = "default"
      + ipv6_association_id              = (known after apply)
      + ipv6_cidr_block                  = (known after apply)
      + main_route_table_id              = (known after apply)
      + owner_id                         = (known after apply)
    }

Plan: 1 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

aws_vpc.myvpc: Creating...
aws_vpc.myvpc: Creation complete after 2s [id=vpc-0dc84c1c7f8c0cdf7]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
```

- Delete the resource: `terraform destroy`

```console
$ terraform destroy
aws_vpc.myvpc: Refreshing state... [id=vpc-0dc84c1c7f8c0cdf7]

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  - destroy

Terraform will perform the following actions:

  # aws_vpc.myvpc will be destroyed
  - resource "aws_vpc" "myvpc" {
      - arn                              = "arn:aws:ec2:eu-west-2:773095993291:vpc/vpc-0dc84c1c7f8c0cdf7" -> null
      - assign_generated_ipv6_cidr_block = false -> null
      - cidr_block                       = "10.0.0.0/16" -> null
      - default_network_acl_id           = "acl-0facf80c8ee78cb9c" -> null
      - default_route_table_id           = "rtb-037c5ad5a02788e0a" -> null
      - default_security_group_id        = "sg-03dc46a4ff59b06a5" -> null
      - dhcp_options_id                  = "dopt-22bd0b4a" -> null
      - enable_dns_hostnames             = false -> null
      - enable_dns_support               = true -> null
      - id                               = "vpc-0dc84c1c7f8c0cdf7" -> null
      - instance_tenancy                 = "default" -> null
      - main_route_table_id              = "rtb-037c5ad5a02788e0a" -> null
      - owner_id                         = "773095993291" -> null
      - tags                             = {} -> null
    }

Plan: 0 to add, 0 to change, 1 to destroy.

Do you really want to destroy all resources?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes

aws_vpc.myvpc: Destroying... [id=vpc-0dc84c1c7f8c0cdf7]
aws_vpc.myvpc: Destruction complete after 1s

Destroy complete! Resources: 1 destroyed.
```

- Terraform lifecycle:
  - `init`ialise a directory/folder
  - `plan` and check to see what we are going to create
  - `apply` to create resource
  - when we are done with it, `destroy` (delete) the resource
- When Terraform creates resources, it will use the default VPC
  - errors if you don't have one
- State file (`terraform.tfstate`) keeps track of all the changes we make

### Variables 101

- Variables are a way to set values to be used multiple times
- Defining and using variables: [`variables/main.tf`](variables/main.tf)
  - string, number, boolean, list, map, tuple, object
  - input, output
- Input variable in action:

```console
$ terraform plan
var.inputname
  Set the name of the VPC

  Enter a value: inputvpc

Refreshing Terraform state in-memory prior to plan...
...


------------------------------------------------------------------------

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_vpc.myvpc will be created
  + resource "aws_vpc" "myvpc" {
      ...
      + tags                             = {
          + "Name" = "inputvpc"
        }
    }

Plan: 1 to add, 0 to change, 0 to destroy.

------------------------------------------------------------------------
```

- Output in action:

```console
$ terraform apply
var.inputname
  Set the name of the VPC

  Enter a value: inputtest

      ...
      + tags                             = {
          + "Name" = "inputtest"
        }
    }

Plan: 1 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + vpcid = (known after apply)

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

aws_vpc.myvpc: Creating...
aws_vpc.myvpc: Creation complete after 2s [id=vpc-0009774c932c1b182]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

Outputs:

vpcid = vpc-0009774c932c1b182
```

## EC2

- Setting up an EC2 instance
  - [`ec2/main.tf`](ec2/main.tf)
  - documentation: <https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance>
- Copy one of the AMI IDs at <https://eu-west-2.console.aws.amazon.com/ec2/v2/home?region=eu-west-2#LaunchInstanceWizard:>
  - e.g., `ami-0a669382ea0feb73a`

```console
$ terraform apply

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_instance.ec2 will be created
  + resource "aws_instance" "ec2" {
      + ami                          = "ami-0a669382ea0feb73a"
      + arn                          = (known after apply)
      + associate_public_ip_address  = (known after apply)
      + availability_zone            = (known after apply)
      + cpu_core_count               = (known after apply)
      + cpu_threads_per_core         = (known after apply)
      + get_password_data            = false
      + host_id                      = (known after apply)
      + id                           = (known after apply)
      + instance_state               = (known after apply)
      + instance_type                = "t2.micro"
      + ipv6_address_count           = (known after apply)
      + ipv6_addresses               = (known after apply)
      + key_name                     = (known after apply)
      + outpost_arn                  = (known after apply)
      + password_data                = (known after apply)
      + placement_group              = (known after apply)
      + primary_network_interface_id = (known after apply)
      + private_dns                  = (known after apply)
      + private_ip                   = (known after apply)
      + public_dns                   = (known after apply)
      + public_ip                    = (known after apply)
      + secondary_private_ips        = (known after apply)
      + security_groups              = (known after apply)
      + source_dest_check            = true
      + subnet_id                    = (known after apply)
      + tenancy                      = (known after apply)
      + volume_tags                  = (known after apply)
      + vpc_security_group_ids       = (known after apply)

      + ebs_block_device {
          + delete_on_termination = (known after apply)
          + device_name           = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + kms_key_id            = (known after apply)
          + snapshot_id           = (known after apply)
          + volume_id             = (known after apply)
          + volume_size           = (known after apply)
          + volume_type           = (known after apply)
        }

      + ephemeral_block_device {
          + device_name  = (known after apply)
          + no_device    = (known after apply)
          + virtual_name = (known after apply)
        }

      + metadata_options {
          + http_endpoint               = (known after apply)
          + http_put_response_hop_limit = (known after apply)
          + http_tokens                 = (known after apply)
        }

      + network_interface {
          + delete_on_termination = (known after apply)
          + device_index          = (known after apply)
          + network_interface_id  = (known after apply)
        }

      + root_block_device {
          + delete_on_termination = (known after apply)
          + device_name           = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + kms_key_id            = (known after apply)
          + volume_id             = (known after apply)
          + volume_size           = (known after apply)
          + volume_type           = (known after apply)
        }
    }

Plan: 1 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

aws_instance.ec2: Creating...
aws_instance.ec2: Still creating... [10s elapsed]
aws_instance.ec2: Still creating... [20s elapsed]
aws_instance.ec2: Creation complete after 22s [id=i-06751a059138204ca]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
```

### Elastic IP

- Setting up an Elastic IP for an EC2 instance
  - [`eip/main.tf`](eip/main.tf)
  - documentation: <https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip>

```console
terraform apply

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_eip.elasticeip will be created
  + resource "aws_eip" "elasticeip" {
      + allocation_id     = (known after apply)
      + association_id    = (known after apply)
      + customer_owned_ip = (known after apply)
      + domain            = (known after apply)
      + id                = (known after apply)
      + instance          = (known after apply)
      + network_interface = (known after apply)
      + private_dns       = (known after apply)
      + private_ip        = (known after apply)
      + public_dns        = (known after apply)
      + public_ip         = (known after apply)
      + public_ipv4_pool  = (known after apply)
      + vpc               = (known after apply)
    }

  # aws_instance.ec2 will be created
  + resource "aws_instance" "ec2" {
      ...
    }

Plan: 2 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

aws_instance.ec2: Creating...
aws_instance.ec2: Still creating... [10s elapsed]
aws_instance.ec2: Still creating... [20s elapsed]
aws_instance.ec2: Still creating... [30s elapsed]
aws_instance.ec2: Creation complete after 33s [id=i-04f7918b8e75fdb79]
aws_eip.elasticeip: Creating...
aws_eip.elasticeip: Creation complete after 1s [id=eipalloc-039d58b23b7c25a4a]

Apply complete! Resources: 2 added, 0 changed, 0 destroyed.

Outputs:

EIP = 3.11.254.176
```

### Security Group

- Setting up a Security Group for an EC2 instance
  - [`sg/main.tf`](sg/main.tf)
  - documentation: <https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group>

```console
$ terraform apply

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_instance.ec2 will be created
  + resource "aws_instance" "ec2" {
      ...
      + security_groups              = [
          + "Allow HTTPS",
        ]
      ...
    }

  # aws_security_group.webtraffic will be created
  + resource "aws_security_group" "webtraffic" {
      + arn                    = (known after apply)
      + description            = "Managed by Terraform"
      + egress                 = [
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = ""
              + from_port        = 443
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 443
            },
        ]
      + id                     = (known after apply)
      + ingress                = [
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = ""
              + from_port        = 443
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 443
            },
        ]
      + name                   = "Allow HTTPS"
      + owner_id               = (known after apply)
      + revoke_rules_on_delete = false
      + vpc_id                 = (known after apply)
    }

Plan: 2 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

aws_security_group.webtraffic: Creating...
aws_security_group.webtraffic: Creation complete after 2s [id=sg-0fd29dd47a9299189]
aws_instance.ec2: Creating...
aws_instance.ec2: Still creating... [10s elapsed]
aws_instance.ec2: Still creating... [20s elapsed]
aws_instance.ec2: Creation complete after 22s [id=i-06d14c73cb1f21bc7]

Apply complete! Resources: 2 added, 0 changed, 0 destroyed.
```

### Dynamic Blocks

- Takes a list, go through all elements, and turn them into Terraform code
  - [`dynamic/main.tf`](dynamic/main.tf)
  - documentation: <https://www.terraform.io/docs/configuration/expressions.html#dynamic-blocks>

```console
$ terraform apply

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_instance.ec2 will be created
  + resource "aws_instance" "ec2" {
      ...
    }

  # aws_security_group.webtraffic will be created
  + resource "aws_security_group" "webtraffic" {
      + arn                    = (known after apply)
      + description            = "Managed by Terraform"
      + egress                 = [
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = ""
              + from_port        = 25
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 25
            },
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = ""
              + from_port        = 3306
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 3306
            },
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = ""
              + from_port        = 443
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 443
            },
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = ""
              + from_port        = 53
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 53
            },
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = ""
              + from_port        = 8080
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 8080
            },
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = ""
              + from_port        = 80
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 80
            },
        ]
      + id                     = (known after apply)
      + ingress                = [
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = ""
              + from_port        = 443
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 443
            },
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = ""
              + from_port        = 80
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 80
            },
        ]
      + name                   = "Allow HTTPS"
      + owner_id               = (known after apply)
      + revoke_rules_on_delete = false
      + vpc_id                 = (known after apply)
    }

Plan: 2 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

aws_security_group.webtraffic: Creating...
aws_security_group.webtraffic: Creation complete after 2s [id=sg-09df893e20000b564]
aws_instance.ec2: Creating...
aws_instance.ec2: Still creating... [10s elapsed]
aws_instance.ec2: Still creating... [20s elapsed]
aws_instance.ec2: Creation complete after 22s [id=i-020fbef19a27f7df0]

Apply complete! Resources: 2 added, 0 changed, 0 destroyed.
```

### Challenge 2

1. Create a DB Server and output the private IP.
2. Create a Web Server and ensure it has a fixed public IP. Output the public IP.
3. Create a Security Group for the web server opening ports 80 and 443.
4. Run the script [`challenge2/server-script.sh`](challenge2/server-script.sh) on the web server.

See [`challenge2/main.tf`](challenge2/main.tf)

## Other Resources

- <https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/aws-get-started>
- <https://github.com/addamstj/Terraform-012>
- <https://www.terraform.io/docs/configuration/index.html>
- <https://www.terraform.io/docs/configuration/syntax.html>
