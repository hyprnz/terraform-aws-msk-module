# 4. Configurable Internal VPC

Date: 2020-02-14

## Status

In Review

## Context

This module has an internal VPC module which has default CIDR and Subnet settings. This enables users of the module to focus on the MSK cluster. It also means that if these default settings are used by another VPC in the users AWS environment the module will not work. We expect people may want to use this module, without having to create a separate VPC, but without using the default settings

## Decision

To enable non-default settings to be used the internal VPC CIDR and Subnet settings are exposed for configuration. This provides a simple way to create an additional VPC for the MSK cluster without using an external VPC module.

## Consequences

The initial internal VPC module needs to be updated to accept configurations from the module level. This adds some complexity to the internal VPC implementation, but it adds a significant required user experience.
