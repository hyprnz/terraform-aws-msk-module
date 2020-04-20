variable "cluster_name" {
  type        = string
  description = "Name of the MSK Cluster to associate the Client Instance with"
}

variable "cluster_vpc_id" {
  type        = string
  description = "ID of the MSK Cluster VPC to associate the Client Instance with"
}

variable "client_instance_type" {
  description = "The EC2 Client Instance Type"
  type        = string
  default     = "m5.large"
}

variable "client_subnet_id" {
  description = "The Public Subnet to launch the Client Instance in"
  type        = string
}

variable "msk_security_group_id" {
  description = "The MSK Cluster Security group to add Security Rules to"
  type        = string
}

variable "default_security_group_id" {
  description = "The default MSK Cluster Security group"
  type        = string
}

variable "cwagent_log_group_name" {
  description = "The name of the CloudWatch log group where the instance logs are sent."
  type        = string
}

variable "cwagent_log_group_retention_period" {
  description = "The CloudWatch Log Group rentention period in days. Defaults to `30` days"
  default     = 30
}
