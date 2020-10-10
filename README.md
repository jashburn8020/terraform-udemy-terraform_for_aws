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

## Other Resources

- <https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/aws-get-started>
- <https://github.com/addamstj/Terraform-012>
