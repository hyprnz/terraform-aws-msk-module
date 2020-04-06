# Internal Terraform Modules
Here you will find internal modules for the MSK Cluster Terraform module. These
may be used in the actual MSK Cluster provisioning, for utilities or for
specific use cases.

## Current Modules

* [VPC](./vpc)
* [Key Pair](./key-pair)
* [Client Instance](./client-instance)

## VPC
Used as an internal module when no external VPC is supplied by users of the
module.

## Key Pair
Used as a utility to import an existing Key Pair into AWS for use in EC2
instances within the MSK Cluster.

## Client Instance
Used as a utility to create a Client Instance for use in an MSK Cluster
