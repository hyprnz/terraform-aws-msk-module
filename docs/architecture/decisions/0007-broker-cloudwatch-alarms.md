# 7. Broker CloudWatch Alarms

Date: 2020-03-12

## Status

Accepted

## Context

To avoid running out of disk space for messages in the MSK Cluster it is [best
practice](https://docs.aws.amazon.com/msk/latest/developerguide/bestpractices.html) to monitor disk space. This can be done using a CloudWatch alarm, or third party support.

## Decision

We will create a Broker CloudWatch Alarm to monitor the `KafkaDataLogsDiskUsed`
metric provided for each broker. An Alarm will be created for each broker in the
cluster. This Alarm will only be created if the module is using a CloudWatch
Dashboard as the assumption is that if you use another monitoring tool you would
set up the alarm in the tooling being used.

At this time we do not plan to provide any notification or actions to be
performed when this Alarm is breached as there are a number of options to use
when this occurs.

## Consequences

The module will report and Alarm within AWS on Broker disk space issues. At this
time the AWS console will be the only place this is seen. We could add an SNS
email option as an option at a later date.

Future work could provide some support tooling within the module to perform the
tasks that are suggested when this is breached.
