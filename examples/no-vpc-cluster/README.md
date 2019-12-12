# MSK Cluster with an External VPC Example
Here you will find an example configuration for using the MSK Cluster Terraform
module with an External VPC.

The `main.tf` contains the module configuration discussed here.

## The Configuration
Users of the module need to provide the VPC client subnets and security group 
information default from the External VPC when using this configuration.

This example uses a VPC module found in the `vpc.tf` file. The VPC should be
provisioned before trying to provision the MSK Cluster. This replicates the
behaviour required to use an External VPC.

```
module "msk" {
  source = "../../"

  providers {
    aws = "aws"
  }

  # MSK Feature Toggles
  create_vpc                = "false"
  create_msk_cluster        = "true"
  use_custom_configuration  = "false"
  use_client_authentication = "false"

  cluster_name = "MSK-Test-Cluster"

  client_subnets  = ["${module.vpc.private_subnets}"]
  security_groups = ["${module.vpc.default_security_group}"]
}
```

### Feature Flags
As can be seen the `create_vpc` is set to `false` as we are using an External
VPC in this configuration. The `create_msk_cluster` is set to `true`
and the `use_custom_configuration` and `use_client_authentication` flags are set
to `false`. This is actually the default configurations for these values and
could be ommitted. 

The following configuration would provide the same resource outputs.
```
module "msk" {
  source = "../../"

  providers {
    aws = "aws"
  }

  # MSK Feature Toggles
  create_vpc                = "false"

  cluster_name = "MSK-Test-Cluster"

  client_subnets  = ["${module.vpc.private_subnets}"]
  security_groups = ["${module.vpc.default_security_group}"]
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
