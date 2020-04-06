# 6. CloudWatch Dashboards

Date: 2020-03-09

## Status

Accepted

## Context

Once infrastructure is provisioned and resources in use it is good practice to
monitor its use. Amazon MSK provides a default level of metrics that enable
monitoring of the MSK cluster. These metrics are available to CloudWatch.

## Decision

We will create a default CloudWatch Dashboard based on the default level of
metrics and the DataDog example dashboard for MSK based on [this article](https://www.datadoghq.com/blog/monitor-amazon-msk/).

The Dashboard is an optional flag, that can be created by turning on a feature
flag in the configuration.

In addition to the default flag, users may want to provide a custom Dashboard for
use with the module. They may use more fine grained metrics that enable enhanced
monitoring capabilities. To support this we will provide the ability to pass a
custom template into the module for use as the dashboard.

## Consequences

This work entails adding a new feature flag and associated template variable.
The template use is abstracted away from the user, but does add some complexity
for the module developer/maintainer.

The provision of a default dashboard should encourage users to at least monitor
their MSK cluster. The ability to provide a custom one will enable people to
create their own dashboards when the default is not appropriate.
