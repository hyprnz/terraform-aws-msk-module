# MSK Cluster using a Custom Kafka Broker Configuration Example
Here you will find an example configuration for using the MSK Cluster Terraform
module with a Custom Kafka Broker Configuration.

The `main.tf` contains the module configuration discussed here.

## The Configuration
Users wishing to use a custom configuration need to pass the server properties
within the module configuration. The properties that are able to be set can be
found in the [AWS Custom MSK Configurations](https://docs.aws.amazon.com/msk/latest/developerguide/msk-configuration-properties.html) documentation. Properties that are not set explicitly get the values they have in the [Default Amazon MSK Configuration](https://docs.aws.amazon.com/msk/latest/developerguide/msk-default-configuration.html).

```
module "msk" {
  source = "../../"

  providers {
    aws = "aws"
  }

  # MSK Feature Toggles
  create_vpc                = "true"
  create_msk_cluster        = "true"
  use_custom_configuration  = "true"
  use_client_authentication = "false"

  cluster_name = "MSK-Custom-Config-Cluster"

  server_properties = <<EOF
auto.create.topics.enable = true
delete.topic.enable = true
EOF
}
```

### Feature Flags
As can be seen the `create_vpc` and `create_msk_cluster` flags are set to `true`
and the and `use_client_authentication` flag is set to `false`. The
`use_custom_configuration` is set to true as we wish to use it. If we remove the
default value flags we can simplify the configuration.

The following configuration would provide the same resource outputs.
```
module "msk" {
  source = "../../"

  providers {
    aws = "aws"
  }

  # MSK Feature Toggles
  use_custom_configuration  = "true"

  cluster_name = "MSK-Custom-Config-Cluster"

  server_properties = <<EOF
auto.create.topics.enable = true
delete.topic.enable = true
EOF
}
```

In the examples we have used the verbose way of representing the flags to
highlight the use of flags. Your own implementations do not need to follow this
representation, but you should set some guidelines around usage of the flags to
avoid confusion.

## Using Custom Configurations
Custom configurations can not be deleted once created and need to have unique
names. Using this example will create an initial custom configuration attached
to the MSK cluster.

### NOT Able To Update Custom Configurations 
**NOTE** It is not possible to update the custom configuration once it is
created at this time without changing the configuration name. There does not
appear to be a way to update the existing custom configuration using the
Terraform provider. This is due to the AWS API not supporting it at this time.
See [this](https://github.com/terraform-providers/terraform-provider-aws/issues/10902) GitHub Issue and [this response](https://github.com/terraform-providers/terraform-provider-aws/issues/10902#issuecomment-567925861) for a fuller description.

To update a custom configuration a new named custom configuration must be
provided. This can be done by providing the `custom_configuration_name` 
and `custom_configuration_description`.

```
module "msk" {
  source = "../../"

  providers {
    aws = "aws"
  }

  # MSK Feature Toggles
  use_custom_configuration  = "true"

  cluster_name = "MSK-Custom-Config-Cluster"

  custom_configuration_name = "Test-MSK-Config"
  custom_configuration_description = "Test MSK Config Description"

  server_properties = <<EOF
auto.create.topics.enable = true
delete.topic.enable = true
log.roll.ms = 604800000
EOF
}
```

This will create a new custom configuration and depending upon the properties
changed the cluster may do a rolling update.

### Passing an Existing Custom Configuration
When wanting to use an existing custom configuration the configuration `arn` and
`revision` can be used to associate the configuration with a cluster. When
passing these parameters the configuation should be similar to this: 

```
module "msk" {
  source = "../../"

  providers {
    aws = "aws"
  }

  # MSK Feature Toggles
  create_vpc                = "true"
  create_msk_cluster        = "true"
  use_custom_configuration  = "true"
  use_client_authentication = "false"

  cluster_name = "MSK-Custom-Config-Cluster"

  msk_configuration_arn = "<MSK_CONFIGURATION_ARN>"
  msk_configuration_revision = 1
}
```

## Regional Support
By default the AWS resources for this example will be created in
`ap-southeast-2`. If you wish to change this you will need to either update the
value of `my_region` in `vars.tf` or provide the `my_region` value as a runtime
parameter with the appropriate value.
