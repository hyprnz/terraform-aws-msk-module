# 8. Key Pair Utility

Date: 2020-03-12

## Status

Superceded by [10. Use Session Manager for shell access to instances](0010-use-session-manager-for-shell-access-to-instances.md)

## Context

When creating a Client Instance for test use in the MSK Cluster a Key Pair is
needed for the EC2 instance to be accessed.

## Decision

We have decided to provide a KeyPair utility that will enable users to import an
existing key into AWS for use in this scenario. We will not provide a key
generation mechanism.

## Consequences

Users wanting to run the Client Instance Example will need to have a generated
key value pair prior to using the utility.
