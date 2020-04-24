# MSK Cluster Internal VPC Terraform Module

Terraform module to provision an Amazon Virtual Private Cloud (VPC) to host an
MSK Cluster in. This [VPC](https://aws.amazon.com/vpc/) simplifies the
provisioning of an MSK Cluster for users of this module. By default it
provisions a High Availability (HA) and fault tolerant VPC.

The module can be used with the default values, or provided with different
values to prevent collisions with existing VPCs.

## Providers

| Name | Version |
|------|---------|
| aws | ~> 2.40 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| cidr\_block | VPC CIDR block | `string` | `"10.0.0.0/16"` | no |
| create\_vpc | Whether or not to create the VPC | `bool` | `true` | no |
| module\_tags | Additional tags to apply to all module resources | `map(any)` | `{}` | no |
| private\_subnets | Private subnets for the VPC | `list(string)` | <pre>[<br>  "10.0.1.0/24",<br>  "10.0.2.0/24",<br>  "10.0.3.0/24"<br>]<br></pre> | no |
| public\_subnets | Public subnets for the VPC | `list(string)` | <pre>[<br>  "10.0.0.0/24"<br>]<br></pre> | no |
| vpc\_name | VPC name | `string` | `"MSK-VPC"` | no |
| vpc\_tags | Additional tags to apply to any provisioned vpc resources | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| default\_security\_group | The default security group for the VPC |
| id | The ID of the VPC created |
| private\_subnets | The private subnets in the VPC created |
| public\_subnets | The public subnets in the VPC created |

