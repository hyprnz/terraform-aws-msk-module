# MSK Client Instance Terraform Module
Terraform module to provision an EC2 MSK Client instance to test/exercise a
cluster. The provisioned client can be used to create and test topics, run
performance scripts and more. By default it will create the Client Instance in
the same VPC as the MSK Cluster.

This module can be used as a starting point for how to establish secure
connection to the MSK Cluster based on adding rules to the MSK Cluster Security
Group.

**NOTE** - Prior to using this module you will need to have provisioned an AWS
keypair in the AWS Account being used. The keypair utility provided with this
module can help with this.

## Providers

| Name | Version |
|------|---------|
| aws | ~> 2.40 |
| template | ~> 2.1.2 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| client\_instance\_type | The EC2 Client Instance Type | `string` | `"m5.large"` | no |
| client\_subnet\_id | The Public Subnet to launch the Client Instance in | `string` | n/a | yes |
| cluster\_name | Name of the MSK Cluster to associate the Client Instance with | `string` | n/a | yes |
| cluster\_vpc\_id | ID of the MSK Cluster VPC to associate the Client Instance with | `string` | n/a | yes |
| default\_security\_group\_id | The default MSK Cluster Security group | `string` | n/a | yes |
| keypair\_name | The name of the AWS Key Pair to use for SSH Access to Client Instance | `string` | `"MSK-Client"` | no |
| msk\_security\_group\_id | The MSK Cluster Security group to add Security Rules to | `string` | n/a | yes |
| ssh\_location | SSH Location IP Address that enables access to the Client Instance | `list` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| kafka\_security\_group\_id | Kafka Client Instance Security Group ID |
