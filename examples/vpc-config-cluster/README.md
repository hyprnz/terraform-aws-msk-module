# MSK Cluster with Configured Internal VPC Example
Here you will find an example configuration for using the MSK Cluster Terraform
module with a Configured Internal VPC.

The `main.tf` contains the module configuration discussed here.

## The Configuration
Users of the module need to provide the configuration for the VPC. This consists
of the name, CIDR block and lists of public and private subnets. These values
will be used to override the default values provided for the Internal VPC

```
module "msk" {
  source = "../../"

  providers {
    aws = "aws"
  }

  # MSK Feature Toggles
  create_vpc                = "true"
  create_msk_cluster        = "true"
  use_custom_configuration  = "false"
  use_client_authentication = "false"

  cluster_name = "MSK-Test-Cluster"

  # VPC Configuration
  vpc_name            = "MSK-VPC-Test"
  vpc_cidr_block      = "10.1.0.0/16"
  vpc_public_subnets  = ["10.1.0.0/24"]
  vpc_private_subnets = ["10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24"]
}
```

### Feature Flags
As can be seen the `create_vpc` and `create_msk_cluster` flags are set to `true`
and the `use_custom_configuration` and `use_client_authentication` flags are set
to `false`. This is actually the default configurations for these values and
could be omitted.

The following configuration would provide the same resource outputs.
```
module "msk" {
  source = "../../"

  providers {
    aws = "aws"
  }

  cluster_name = "MSK-Test-Cluster"

  # VPC Configuration
  vpc_name            = "MSK-VPC-Test"
  vpc_cidr_block      = "10.1.0.0/16"
  vpc_public_subnets  = ["10.1.0.0/24"]
  vpc_private_subnets = ["10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24"]
}
```

In the examples we have used the verbose way of representing the flags to
highlight the use of flags. Your own implementations do not need to follow this
representation, but you should set some guidelines around usage of the flags to
avoid confusion.

## Regional Support
By default the AWS resources for this example will be created in
`ap-southeast-2`. If you wish to change this you will need to either update the
value of `my_region` in `vars.tf` or provide the `my_region` value as a runtime
parameter with the appropriate value.
