# Terraform for AWS - Beginner to Expert 2020 (0.12)

Notes and examples from the Terraform for AWS course in Udemy

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
    - _can be more granular_
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

- Create [`main.tf`](first-resource/main.tf)
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

## Other Resources

- <https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/aws-get-started>
- <https://github.com/addamstj/Terraform-012>
- <https://www.terraform.io/docs/configuration/index.html>
- <https://www.terraform.io/docs/configuration/syntax.html>
