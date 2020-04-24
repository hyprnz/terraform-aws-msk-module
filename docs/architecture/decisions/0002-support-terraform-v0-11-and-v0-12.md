# 2. Support Terraform v0.11 and v0.12

Date: 2019-12-13

## Status

Accepted

## Context

Terraform has recently released version v0.12. [Upgrading to Terraform
v0.12](https://www.terraform.io/upgrade-guides/0-12.html) is significantly more
effort than previous Terraform upgrades due to a number of
[incompatibilities](https://www.terraform.io/upgrade-guides/0-12.html).

Hypr has clients using the v0.11 of modules at this time. Whilst these clients
continue to use v0.11 modules, any new modules created should also be available
to these clients.

Terraform v0.12 provides a significant number of improvements that enable
modules to be less verbose, with less workarounds to achieve the same results as
those written using v0.11.

## Decision

This module will support both Terraform v0.11 and v0.12 module users.

The `master` branch of this module will contain the v0.12 version of this
module, whilst a `0.11` branch will hold the v0.11 version. This is a common
pattern prevalent in the Terraform Module community at this time.

Users should still be encouraged to upgrade their Terraform to v0.12, but by
providing a v0.11 version of the module they do not miss out on the
functionality provided by the module at this time.

## Consequences

Using a branch for each Terraform version supported provides users of this
module with relevant autonomy. Users who have not yet moved to Terraform v0.11
can use the `0.11` branch, until such time as they switch to Terraform v0.12.

When using the v0.11 version of the module users will need to incorporate the
branch into there source definition. Documentation on this should be provided in
the usage section.

Due to limitations with optional arguments, and the number of optional
arguments the [Terraform AWS MKS Cluster Resource](https://www.terraform.io/docs/providers/aws/r/msk_cluster.html) the v0.11 version of the module may become far more complex than the v0.12 version of the module.
