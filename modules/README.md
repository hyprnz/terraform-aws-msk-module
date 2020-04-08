# Internal Terraform Modules
Here you will find internal modules for the MSK Cluster Terraform module. These
may be used in the actual MSK Cluster provisioning, for utilities or for
specific use cases.

## Current Modules

* [VPC](./vpc)
* [Client Instance](./client-instance)

## VPC
Used as an internal module when no external VPC is supplied by users of the
module.

## Client Instance
Used as a utility to create a Client Instance for use in an MSK Cluster
