# Configuration change
terraform {
  backend "s3" {
    # Folder path on where you want to store the state file
    key    = "terraform/tfstate.tfstate"
    bucket = "jashburn-remote-backend-2010"
    region = "eu-west-2"
    # Credentials - as saved in ~/.aws/credentials if you're using AWS CLI.
    # You can leave these blank.
    access_key = ""
    secret_key = ""
  }
}
