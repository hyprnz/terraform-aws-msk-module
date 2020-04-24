# MSK Client Instance Terraform Module
Terraform module to provision an EC2 MSK Client instance to test/exercise a
cluster. The provisioned client can be used to create and test topics, run
performance scripts and more. By default it will create the Client Instance in
the same VPC as the MSK Cluster.

This module can be used as a starting point for how to establish secure
connection to the MSK Cluster based on adding rules to the MSK Cluster Security
Group.

## Providers

| Name | Version |
|------|---------|
| aws | ~> 2.40 |
| template | ~> 2.1.2 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| client\_subnet\_id | The Public Subnet to launch the Client Instance in | `string` | n/a | yes |
| cluster\_name | Name of the MSK Cluster to associate the Client Instance with | `string` | n/a | yes |
| cluster\_vpc\_id | ID of the MSK Cluster VPC to associate the Client Instance with | `string` | n/a | yes |
| cwagent\_log\_group\_name | The name of the CloudWatch log group where the instance logs are sent. | `string` | n/a | yes |
| default\_security\_group\_id | The default MSK Cluster Security group | `string` | n/a | yes |
| msk\_security\_group\_id | The MSK Cluster Security group to add Security Rules to | `string` | n/a | yes |
| client\_instance\_type | The EC2 Client Instance Type | `string` | `"m5.large"` | no |
| cwagent\_log\_group\_retention\_period | The CloudWatch Log Group retention period in days. Defaults to `30` days | `number` | `30` | no |

## Outputs

| Name | Description |
|------|-------------|
| kafka\_security\_group\_id | Kafka Client Instance Security Group ID |

