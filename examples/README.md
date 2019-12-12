# MSK Module Feature Examples
Here you will find examples of how to use the [MSK Terraform Module](../).

## Configuration Features

This module supports the following MSK cluster configurations:

1. [MSK Cluster with Default Internal VPC](./default-cluster)
2. [MSK Cluster with Configured Internal VPC](./vpc-config-cluster)
3. [MSK Cluster with an External VPC](./no-vpc-cluster)
4. [MSK Cluster using a Custom Kafka Broker Configuration](./custom-config-cluster)
5. [MSK Cluster using Client Authentication](./default-ca-cluster)

Here you will find an example for each of these configurations.

Please refer to the example that best suits your use case to learn more about
the configuration.

## Regional Support
By default the AWS resources for these examples will be created in
`ap-southeast-2`. If you wish to change this you will need to either update the
value of `my_region` in `vars.tf` or provide the `my_region` value as a runtime
parameter with the appropriate value in the example.
