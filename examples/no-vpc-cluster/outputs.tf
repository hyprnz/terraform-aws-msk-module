output "msk_cluster_arn" {
  description = "The ARN for the MSK Cluster"
  value       = "${module.msk.arn}"
}

output "zookeeper_connect_string" {
  description = "Zookeeper connection string"
  value       = "${module.msk.zookeeper_connect_string}"
}

output "bootstrap_brokers" {
  description = "TLS connection host:port pairs"
  value       = "${module.msk.bootstrap_brokers_tls}"
}

output "encryption_at_rest_kms_key_arn" {
  description = "The ARN of the KMS key used for encryption at rest of the broker data volume"
  value       = "${module.msk.encryption_at_rest_kms_key_arn}"
}
