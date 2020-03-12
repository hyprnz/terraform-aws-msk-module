# Key Pair Utility Terraform Module
Terraform module to import a private/public key pairs public key to enable use
with EC2 instances. This module enables the user to import an existing public
key into AWS for use when connecting to an EC2 instance.

This module can be used to import a key for use in the Client Instance example
so that users can access the Client Instance.

## Providers

| Name | Version |
|------|---------|
| aws | ~> 2.40 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| key\_name | Name for the AWS Key Pair | `string` | n/a | yes |
| public\_key\_extension | Public key extension | `string` | `".pub"` | no |
| ssh\_public\_key\_path | Path to the SSH public key directory | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| fingerprint | The MD5 public key fingerprint as specified in section 4 of RFC 476 |
| id | The key pair ID |
| name | The key pair name |
| public\_key\_filename | Public Key filename |
