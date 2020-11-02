# Amazon MSK Terraform Module

Terraform module to provision an Amazon Managed Streaming for Apache Kafka
Cluster in AWS. An [Amazon MSK](https://aws.amazon.com/msk/) Cluster requires a
VPC to run the Broker instances in. This module provides an [Internal VPC](./modules/vpc) to
simplify provisioning the MSK Cluster. This Internal VPC can be configured to
ensure it does not collide with any existing VPCs.

By default all data is encrypted at rest using an [AWS managed
CMK](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#aws-managed-cmk).
Users may provide their own key if they don't wish to use the AWS managed key.
All data in transit is encrypted using TLS between the brokers.

A CloudWatch MSK Cluster Dashboard and CloudWatch Broker Data Log Disk Usage
Alarm are optional resources available with this module. A default CloudWatch
Dashboard is provided, but a custom Dashboard may also be provided. This enables
clusters using enhanced monitoring to add additional metrics to the Dashboard.
The CloudWatch Alarm is provided for each of the brokers in the MSK cluster to
warn of Broker Disk Usage greater than 85% as per the [best
practices](https://docs.aws.amazon.com/msk/latest/developerguide/bestpractices.html).

## Good Practices
When using this module it is recommended that users determine the appropriate
size of their MSK Cluster and understand the cost using the [MSK Sizing and
Pricing](https://amazonmsk.s3.amazonaws.com/MSK_Sizing_Pricing.xlsx) spreadsheet.
Users should test their configurations with appropriate workloads after
provisioning the cluster.

## Features & Examples

This module supports the following MSK cluster configurations:

1. MSK Cluster with Default Internal VPC
2. MSK Cluster with Configured Internal VPC
3. MSK Cluster with an External VPC
4. MSK Cluster using a Custom Kafka Broker Configuration
5. MSK Cluster using Client Authentication
6. MSK Cluster with CloudWatch Dashboard
7. MSK Cluster with CloudWatch Broker Data Log Disk Usage Alarm
8. MSK Cluster with Client Instance

These are implemented using feature flags. For information on how to configure
the MSK cluster in these configurations see the [examples](./examples)
directory. Flags can be combined, such as enabling both the CloudWatch Dashboard
and the CloudWatch Broker Data Log Disk Usage Alarm.

## Providers

| Name | Version |
|------|---------|
| aws | ~> 2.40 |
| template | ~> 2.1.2 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| cluster\_name | Name of the MSK Cluster | `string` | n/a | yes |
| broker\_ebs\_volume\_size | Size in GiB of the EBS volume for the data drive on each broker node | `number` | `2000` | no |
| broker\_node\_instance\_type | Instance type to use for the Kafka brokers | `string` | `"kafka.m5.large"` | no |
| certificate\_authority\_arns | List of ACM Certificate Authority Amazon Resource Names (ARNS) | `list(string)` | `[]` | no |
| client\_broker\_encryption | Encryption setting for data in transit between clients and brokers. Valid values: TLS, TLS\_PLAINTEXT and PLAINTEXT | `string` | `"TLS"` | no |
| client\_subnets | A list of subnets to connect to in the client VPC | `list(string)` | `[]` | no |
| create\_dashboard | Whether or not to create the MSK Dashboard | `bool` | `false` | no |
| create\_diskspace\_cw\_alarm | Whether or not to create a Broker Diskspace CloudWatch Alarm | `bool` | `false` | no |
| create\_msk\_cluster | Whether or not to create the MSK Cluster | `bool` | `true` | no |
| create\_vpc | Whether or not to create the MSK VPC | `bool` | `true` | no |
| custom\_configuration\_description | Description of the MSK Custom configuration | `string` | `"Custom MSK Configuration Example properties"` | no |
| custom\_configuration\_name | Name of the MSK Custom configuration | `string` | `"Custom-MSK-Configuration-Example"` | no |
| custom\_dashboard\_template | Location for the custom MSK Dashboard template | `string` | `""` | no |
| encryption\_kms\_key\_arn | KMS key short ID or ARN to use for encrypting your data at rest. If no key is specified an AWS managed KMS key will be used for encrypting the data at rest | `string` | `""` | no |
| enhanced\_monitoring\_level | Desired enhanced MSK CloudWatch monitoring level. Valid values are DEFAULT, PER\_BROKER, or PER\_TOPIC\_PER\_BROKER | `string` | `"DEFAULT"` | no |
| in\_cluster\_encryption | Whether data communication among broker nodes is encrypted | `bool` | `true` | no |
| jmx\_exporter\_enabled | Whether Prometheus JMX export is enabled | `bool` | `false` | no |
| kafka\_version | Desired Kafka software version | `string` | `"2.2.1"` | no |
| monitoring\_tags | Additional tags to apply to any provisioned monitoring/metric resources | `map(any)` | `{}` | no |
| msk\_cluster\_tags | Additional tags to apply to msk\_cluster resources | `map(any)` | `{}` | no |
| msk\_configuration\_arn | ARN of the MSK Configuration to use in the cluster | `string` | `""` | no |
| msk\_configuration\_revision | Revision of the MSK Configuration to use in the cluster | `number` | `1` | no |
| node\_exporter\_enabled | Whether Prometheus JMX export is enabled | `bool` | `false` | no |
| num\_of\_broker\_nodes | Desired total number of broker nodes in the kafka cluster. It must be a multiple of the number of specified client subnets | `number` | `3` | no |
| s3\_logging\_bucket | Which s3 bucket to use for logging | `string` | `""` | no |
| s3\_logging\_enabled | Whether logging to s3 bucket is enabled | `bool` | `false` | no |
| security\_groups | A list of the security groups to associate with the elastic network interfaces to control who can communicate with the cluster | `list(string)` | `[]` | no |
| server\_properties | Contents of the server.properties file for Kafka broker | `string` | `"auto.create.topics.enable = false\ndefault.replication.factor = 3\ndelete.topic.enable = true\nmin.insync.replicas = 2\nnum.io.threads = 8\nnum.network.threads = 5\nnum.partitions = 1\nnum.replica.fetchers = 2\nsocket.request.max.bytes = 104857600\nunclean.leader.election.enable = true\n"` | no |
| tags | Additional tags to apply to all module resources | `map(any)` | `{}` | no |
| use\_client\_authentication | Use client authentication | `bool` | `false` | no |
| use\_custom\_configuration | Use a custom configuration on each Kafka Broker | `bool` | `false` | no |
| vpc\_cidr\_block | VPC CIDR block | `string` | `"10.0.0.0/16"` | no |
| vpc\_id | The VPC ID for the MSK Cluster | `string` | `""` | no |
| vpc\_name | VPC name | `string` | `"MSK-VPC"` | no |
| vpc\_private\_subnets | Private subnets for the VPC | `list(string)` | <pre>[<br>  "10.0.1.0/24",<br>  "10.0.2.0/24",<br>  "10.0.3.0/24"<br>]<br></pre> | no |
| vpc\_public\_subnets | Public subnets for the VPC | `list(string)` | <pre>[<br>  "10.0.0.0/24"<br>]<br></pre> | no |
| vpc\_tags | Additional tags to apply to any provisioned vpc resources | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| arn | The ARN for the MSK Cluster |
| bootstrap\_brokers | List of hostname:port pairs of Kafka brokers suitable to bootstrap connectivity to the Kafka Cluster |
| bootstrap\_brokers\_tls | List of hostname:port pairs of Kafka brokers suitable to bootstrap connectivity to the Kafka Cluster |
| client\_authentication | Certificate authority arns used for client authentication |
| cloudwatch\_dashboard\_arn | The ARN of the MSK Cloudwatch dashboard |
| cloudwatch\_diskspace\_alarm\_arn | The ARN of the Broker Diskspace CloudWatch Alarm for the MSK Cluster |
| cloudwatch\_diskspace\_alarm\_id | The ID of the Broker Diskspace CloudWatch Alarm for the MSK Cluster |
| custom\_configuration\_arn | Custom configuration ARN |
| custom\_configuration\_latest\_revision | The latest revision of the MSK custom configuration |
| encryption\_at\_rest\_kms\_key\_arn | The ARN of the KMS key used for encryption at rest of the broker data volume |
| msk\_security\_group\_id | MSK Cluster Security Group ID |
| private\_subnets | The private subnets in the VPC created |
| public\_subnets | The public subnets in the VPC created |
| security\_group | The ID of the security group created for the MSK clusters |
| vpc\_id | The ID of the VPC created |
| zookeeper\_connect\_string | Zookeeper connection string |



## Architectural Decision Records

Important architectural decisions along with their context and consequences are
captured in <a
href="https://www.thoughtworks.com/radar/techniques/lightweight-architecture-decision-records">Lightweight Architecture Decision Records</a>
stored in this repository. These <a
href="http://thinkrelevance.com/blog/2011/11/15/documenting-architecture-decisions">Architecture
Decision Records</a> (ADRs) are created, updated and maintained using the <a
href="https://github.com/npryce/adr-tools">ADR Tools</a>. Instructions for
installing the tools can be found <a
href="https://github.com/npryce/adr-tools/blob/master/INSTALL.md">here</a>.

Please read the [ADRs](docs/architecture/decisions/README.md) for this module to
understand the important architectural decisions that have been made.

## License

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

See [LICENSE](LICENSE) for full details.

```
Copyright 2020 Hypr NZ

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

  http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```

Copyright &copy; 2020 [Hypr NZ](https://www.hypr.nz/)
