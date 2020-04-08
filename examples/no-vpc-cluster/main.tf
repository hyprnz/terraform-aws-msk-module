module "msk" {
  source = "../../"

  providers = {
    aws = aws
  }

  # MSK Feature Toggles
  create_vpc                = "false"
  create_msk_cluster        = "true"
  use_custom_configuration  = "false"
  use_client_authentication = "false"

  cluster_name = "MSK-Test-Cluster"

  vpc_id          =  "vpc-0bdfb2be8f349a304" #"${module.vpc.id}"
  client_subnets  =  ["subnet-0dcc16898c1a5e17c", "subnet-02f65aba439cb3c03", "subnet-03f65dc560bfb178e"] #["${module.vpc.private_subnets}"]
  security_groups =  ["sg-05969cd31054bb88d"] #["${module.vpc.default_security_group}"]
}
