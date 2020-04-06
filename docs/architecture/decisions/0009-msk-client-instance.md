# 9. MSK Client Instance

Date: 2020-03-13

## Status

Accepted

## Context

In order to create topics and test the provisioned MSK Cluster a Client Instance
is required. This Client Instance requires Kafka to be installed on it and be
able to access the MSK Cluster.

## Decision

The MSK Client Instance will be built as a separate internal module, that can be
used to add security rules to the MSK Cluster security group to enable access
from it to the brokers. This separates the MSK Client Instance from the Cluster
as you would expect, as consumers and producers are not going to be run in the
MSK Cluster.

The Client Instance will have limited SSH access and then the instance will be
part of the security rule to access the cluster. So only the Client Instance
will be able to access the cluster.

## Consequences

This requires the addition of an MSK Cluster Security Group that rules can be
added to for gaining access to the MSK Cluster. This security group can be used
by other implementations as it will by default be empty upon provisioning.

The separation does mean a number of Cluster information needs to be passed to
the Client Instance. The module could be expanded to provide either a Client
Instance or a Burrow instance for use in the Cluster, which would be a feature
flagged Client Instance implementation.

The Client Instance requires an AWS Keypair to be generated for access to the
instance. A utility module has been implemented to enable users to provision
this from an existing public/private key pair.
