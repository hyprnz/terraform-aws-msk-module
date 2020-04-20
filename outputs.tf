output "vpc_id" {
  description = "The ID of the VPC created"
  value       = module.vpc.id
  depends_on  = [module.vpc]
}

output "public_subnets" {
  description = "The public subnets in the VPC created"
  value       = module.vpc.public_subnets
  depends_on  = [module.vpc]
}

output "private_subnets" {
  description = "The private subnets in the VPC created"
  value       = module.vpc.private_subnets
  depends_on  = [module.vpc]
}

output "security_group" {
  description = "The ID of the security group created for the MSK clusters"
  value       = module.vpc.default_security_group
  depends_on  = [module.vpc]
}

output "msk_security_group_id" {
  description = "MSK Cluster Security Group ID"
  value       = aws_security_group.msk_cluster.id
}

output "arn" {
  description = "The ARN for the MSK Cluster"
  value       = aws_msk_cluster.this[*].arn
  depends_on  = [aws_msk_cluster.this]
}

output "zookeeper_connect_string" {
  description = "Zookeeper connection string"
  value       = aws_msk_cluster.this[*].zookeeper_connect_string
  depends_on  = [aws_msk_cluster.this]
}

# Only contains value if `client_broker` encryption in transit is set to `PLAINTEXT` or `TLS_PLAINTEXT`
output "bootstrap_brokers" {
  description = "List of hostname:port pairs of Kafka brokers suitable to bootstrap connectivity to the Kafka Cluster"
  value       = aws_msk_cluster.this[*].bootstrap_brokers
  depends_on  = [aws_msk_cluster.this]
}

# Only contains value if `client_broker` encryption in transit is set to 'TLS_PLAINTEXT` or `TLS`
output "bootstrap_brokers_tls" {
  description = "List of hostname:port pairs of Kafka brokers suitable to bootstrap connectivity to the Kafka Cluster"
  value       = aws_msk_cluster.this[*].bootstrap_brokers_tls
  depends_on  = [aws_msk_cluster.this]
}

output "encryption_at_rest_kms_key_arn" {
  description = "The ARN of the KMS key used for encryption at rest of the broker data volume"
  value       = aws_msk_cluster.this[*].encryption_info[0].encryption_at_rest_kms_key_arn
  depends_on  = [aws_msk_cluster.this]
}

output "client_authentication" {
  description = "Certificate authority arns used for client authentication"
  value       = local.certificate_authority_arns
}

output "custom_configuration_arn" {
  description = "Custom configuration ARN"
  value       = aws_msk_configuration.this[*].arn
  depends_on  = [aws_msk_configuration.this]
}

output "custom_configuration_latest_revision" {
  description = "The latest revision of the MSK custom configuration"
  value       = aws_msk_configuration.this[*].latest_revision
  depends_on  = [aws_msk_configuration.this]
}

output "cloudwatch_dashboard_arn" {
  description = "The ARN of the MSK Cloudwatch dashboard"
  value       = aws_cloudwatch_dashboard.msk[*].dashboard_arn
  depends_on  = [aws_cloudwatch_dashboard.msk]
}

output "cloudwatch_diskspace_alarm_arn" {
  description = "The ARN of the Broker Diskspace CloudWatch Alarm for the MSK Cluster"
  value       = aws_cloudwatch_metric_alarm.msk_broker_disk_space[*].arn
  depends_on  = [aws_cloudwatch_metric_alarm.msk_broker_disk_space]
}

output "cloudwatch_diskspace_alarm_id" {
  description = "The ID of the Broker Diskspace CloudWatch Alarm for the MSK Cluster"
  value       = aws_cloudwatch_metric_alarm.msk_broker_disk_space[*].id
  depends_on  = [aws_cloudwatch_metric_alarm.msk_broker_disk_space]
}
