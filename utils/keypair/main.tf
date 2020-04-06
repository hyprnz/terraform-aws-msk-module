module "keypair" {
  source = "../../modules/key-pair"

  providers {
    aws = "aws"
  }

  key_name = "MSK-Client"

  ssh_public_key_path = "~/.ssh/"
}
