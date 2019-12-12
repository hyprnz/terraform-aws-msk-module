# 3. Internal VPC

Date: 2020-02-14

## Status

In Review

## Context

Managed Streaming for Apache Kafka (MSK) cluster in AWS requires a VPC to run in. This means that before provisioning an MSK cluster a VPC needs to be provisioned in AWS. The VPC should be set up to deal with High Availability (HA) and fault tolerance

## Decision

To make it simpler to use this module we have included an internal VPC module. This module will be used by default when creating an MSK cluster. This removes the need for users to have to provide their own VPC before using this module.

## Consequences

Users of this module do not have to provision a VPC prior to use. The internal VPC module is a limited version of a VPC based on the needs of an MSK cluster. We will provide the capability to use a full VPC module in conjunction with this module.
