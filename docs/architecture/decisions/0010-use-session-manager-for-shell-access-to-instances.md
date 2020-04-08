# 10. Use Session Manager for shell access to instances

Date: 2020-04-08

## Status

Accepted

Supercedes [8. Key Pair Utility](0008-key-pair-utility.md)

## Context

Providing shell access to a node in AWS is time consuming to set up in a secure manner.

## Decision

Use Session Manager to establish shell connections to the client instance.

## Consequences

Session manager provides connections managed via IAM polices with connection auditing and session history. It also removed the need for establishing an ssh key rotation policy.
