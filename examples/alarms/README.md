# MSK Cluster with CloudWatch Broker Data Log Disk Usage Alarm
Here you will find an example configuration for using the MSK Cluster Terraform
module with an optional CloudWatch Broker Data Log Disk Usage Alarm 

The CloudWatch Alarm can only be enabled in conjunction with the CloudWatch
Dashboard so both the `create_dashboard` and `create_diskspace_cw_alarm` flags will
need to be set. An alarm will be set up for each broker in the MSK cluster and
will fire when it reaches an 85% threshold.

At this time there is no notification carried out and no default actions
performed when the alarm triggers.

The `main.tf` contains the module configuration discussed here.

## The Configuration
All that users of the module need to provide to enable the Alarm using the
default configuration is the name of the MSK cluster and to enable the
`create_dashboard` and `create_diskspace_cw_alarm` flag.

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
  create_diskspace_cw_alarm = "true"
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
  create_dashboard          = "true"
  create_diskspace_cw_alarm = "true"

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
