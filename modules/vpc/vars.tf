variable "create_vpc" {
  description = "Whether or not to create the VPC"
  default     = true
}

variable "vpc_name" {
  description = "VPC name"
  type        = string
  default     = "MSK-VPC"
}

variable "cidr_block" {
  description = "VPC CIDR block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "Public subnets for the VPC"
  type        = list(string)
  default     = ["10.0.0.0/24"]
}

variable "private_subnets" {
  description = "Private subnets for the VPC"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

#tags

variable "module_tags" {
  description = "Additional tags to apply to all module resources"
  type        = map(any)
  default     = {}
}

variable "vpc_tags" {
  description = "Additional tags to apply to any provisioned vpc resources"
  type        = map(any)
  default     = {}
}