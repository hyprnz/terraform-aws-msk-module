# Key Pair Utility Example
Here you will find an example for importing an existing public key into AWS for
use with MSK cluster EC2 instances. Prior to using this module you will need a
generated private/public key pair.

The `main.tf` contains the module configuration discussed here.

## The Configuration
The user needs to provide a `key_name` and the `ssh_public_key_path` variables
to the module. The `key_name` should be the same as the public key filename and
the public key should have the `.pub` extension.

```
module "keypair" {
  source = "../../modules/key-pair"

  providers {
    aws = "aws"
  }

  key_name = "MSK-Client"

  ssh_public_key_path = "~/.ssh/"
}
```

The output will include the `key_pair_id` which is needed for the Client
Instance example.

## Regional Support
By default the AWS resources for this example will be created in
`ap-southeast-2`. If you wish to change this you will need to either update the
value of `my_region` in `vars.tf` or provide the `my_region` value as a runtime
parameter with the appropriate value.
