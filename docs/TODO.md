# TO-DO ITEMS
The document captures the items that have been identified as required or
useful additions to this Terraform module.

* Support Terraform 0.12
* Replace KeyPair with Systems Manager Session Manager
* Pull up shared `locals` variables to a `locals.tf`
* Add Client Instance Example Documentation
* Add Full Example using Internal VPC, with Dashboard, Alarms & Client Instance
* Add SSH Output to Client Instance Module / Example
* Provide Burrow for Consumer-Lag Checking
* Provide ability to create own key for use in encryption
* Add Notification to Broker Alarms
* Add Support Tools to perform actions on Broker Alarms
  * Scale up Broker Storage
  * Adjust the Data Retention Parameters
  * Delete unused topics (Topic Management)
* Provide a way to control access to the Apache Zookeeper nodes
* Add Broker Logging Configuration (Awaiting Provider Implementation)
* Add Open Monitoring Enablement as Optional Feature
* Add Cloudcraft diagrams to examples (including estimated costs)
* Add TerraTest tests to the examples
