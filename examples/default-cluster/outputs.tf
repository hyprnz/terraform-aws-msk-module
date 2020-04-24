output "vpc_id" {
  description = "The ID of the VPC used"
  value       = module.msk.vpc_id
}

output "public_subnets" {
  description = "The public subnets used"
  value       = module.msk.public_subnets
}

output "private_subnets" {
  description = "The private subnets used"
  value       = module.msk.private_subnets
}

output "security_group_id" {
  description = "The ID of the security groups used for the MSK cluster"
  value       = module.msk.security_group
}

output "msk_cluster_arn" {
  description = "The ARN for the MSK Cluster"
  value       = module.msk.arn
}

output "zookeeper_connect_string" {
  description = "Zookeeper connection string"
  value       = module.msk.zookeeper_connect_string
}

output "bootstrap_brokers" {
  description = "TLS connection host:port pairs"
  value       = module.msk.bootstrap_brokers_tls
}

output "encryption_at_rest_kms_key_arn" {
  description = "The ARN of the KMS key used for encryption at rest of the broker data volume"
  value       = module.msk.encryption_at_rest_kms_key_arn
}
