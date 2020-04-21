module "msk" {
  source = "../../"

  providers = {
    aws = aws
  }

  # MSK Feature Toggles
  create_vpc                = true
  create_msk_cluster        = true
  use_custom_configuration  = true
  use_client_authentication = false

  cluster_name = "MSK-Custom-Config-Cluster"

  # MSK custom configs cannot be currently deleted, and casue a name collision error when a name is resued
  custom_configuration_name = "MSK-Custom-Config-Cluster-01"

  server_properties = <<EOF
auto.create.topics.enable = false
delete.topic.enable = true
EOF
}
