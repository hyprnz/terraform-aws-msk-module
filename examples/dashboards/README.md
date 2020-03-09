# MSK Cluster with CloudWatch Dashbard 
Here you will find an example configuration for using the MSK Cluster Terraform
module with an optional CloudWatch Dashboard

The CloudWatch Dashboard can be enabled using the `create_dashboard` flag. This
will create the dashboard using the default module template. A Custom Dashboard
can also be used by passing the `custom_dashboard_template` variable with a path
to the custom template.

The `main.tf` contains the module configuration discussed here.

## The Configuration
All that users of the module need to provide to enable the Dashboard using the
default configuration is the name of the MSK cluster and to enable the
`create_dashboard` flag.

```
module "msk" {
  source = "../../"

  providers {
    aws = "aws"
  }

  # MSK Feature Toggles
  create_vpc                = "true"
  create_msk_cluster        = "true"
  create_dashboard          = "true"
  use_custom_configuration  = "false"
  use_client_authentication = "false"

  cluster_name = "MSK-Test-Cluster"
}
```

### Feature Flags
As can be seen the `create_vpc` and `create_msk_cluster` flags are set to `true`
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

  # MSK Feature Toggles (Non-Defaults)
  create_dashboard = "true"

  cluster_name = "MSK-Test-Cluster"
}
```

In the examples we have used the verbose way of representing the flags to
highlight the use of flags. Your own implementations do not need to follow this
representation, but you should set some guidelines around usage of the flags to
avoid confusion.

## CloudWatch Custom Dashboard
In order to use a custom CloudWatch Dashboard an additional
`custom_dashboard_template` variable needs to be set.

module "msk" {
  source = "../../"

  providers {
    aws = "aws"
  }

  # MSK Feature Toggles
  create_vpc                = "true"
  create_msk_cluster        = "true"
  create_dashboard          = "true"
  use_custom_configuration  = "false"
  use_client_authentication = "false"

  cluster_name = "MSK-Test-Cluster"

  ## Uncomment this line to use the custom dashboard template
  custom_dashboard_template = "templates/dashboard-custom.tpl"
}

Here we are setting the custom dashboard using a template file in this example
directory. This will replace the default template when used.

## Regional Support
By default the AWS resources for this example will be created in
`ap-southeast-2`. If you wish to change this you will need to either update the
value of `my_region` in `vars.tf` or provide the `my_region` value as a runtime
parameter with the appropriate value.
