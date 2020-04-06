variable "create_vpc" {
  description = "Whether or not to create the VPC"
  default     = "true"
}

variable "vpc_name" {
  description = "VPC name"
  default     = "MSK-VPC"
}

variable "cidr_block" {
  description = "VPC CIDR block"
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "Public subnets for the VPC"
  default     = ["10.0.0.0/24"]
}

variable "private_subnets" {
  description = "Private subnets for the VPC"
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}
