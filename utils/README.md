# Utils
Here you will find some useful utilities to help you achieve more with this
module.

## Key Pair
The [Key Pair](./keypair) utility uses the [key-pair](../modules/key-pair)
Terraform module to create an AWS Key Pair for use with MSK Client instances.
You will need to have a private/public key pair already generated before you use
this utility. The utility enables you to upload your public key to AWS for use
in an MSK Client instance configuration.
