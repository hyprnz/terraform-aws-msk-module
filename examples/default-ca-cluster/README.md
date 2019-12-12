# MSK Cluster with Client Authentication Example
Here you will find an example configuration for using the MSK Cluster Terraform
module with Client Authentication

The `main.tf` contains the module configuration discussed here.

## The Configuration
All that users of the module need to provide to use the Client Authentication is
to set the `use_custom_configuration` feature toggle to 'true'

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
  use_client_authentication = "true"

  cluster_name = "MSK-Test-Cluster"
}
```

### Feature Flags
The `use_client_authentication` flag is set to `true`. As can be seen the `create_vpc` and `create_msk_cluster` flags are set to `true` and the `use_custom_configuration` flag is set to `false`. This is actually their default configurations for these values and could be ommitted. 

The following configuration would provide the same resource outputs.
```
module "msk" {
  source = "../../"

  providers {
    aws = "aws"
  }

  # MSK Feature Toggles
  use_client_authentication = "true"

  cluster_name = "MSK-Test-Cluster"
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
