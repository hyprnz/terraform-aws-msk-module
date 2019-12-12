# 5. Feature Flags

Date: 2020-02-14

## Status

In Review

## Context

To make this module user-friendly we need to support a number of identified use cases

1. MSK Cluster / Default Internal VPC
2. MSK Cluster / Configured Internal VPC
3. MSK Cluster / External VPC
4. MSK Cluster using Custom Configuration
5. MSK Cluster using Client Authentication

We should make it simple for users to create an MSK cluster in each of these configurations.

## Decision

To enable this the module will utilise feature toggles. The proposed feature toggles are

1. Create VPC
2. Use Custom Configuration
3. Use Client Authentication

The configured internal VPC will utilise the Create VPC feature flag with additional configuration settings.

## Consequences

To support these flags we will need to implement feature flags in the Terraform code. We will also need to provide good examples of how to use the feature flags. The examples will help users quickly get the configuration they need to set up. There is added complexity in the module as a result, but this is hidden from the module user.
