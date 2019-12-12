module "msk" {
  source = "../../"

  providers {
    aws = "aws"
  }

  # MSK Feature Toggles
  create_vpc                = "true"
  create_msk_cluster        = "true"
  use_custom_configuration  = "true"
  use_client_authentication = "false"

  cluster_name = "MSK-Custom-Config-Cluster"

  server_properties = <<EOF
auto.create.topics.enable = true
delete.topic.enable = true
EOF
}
