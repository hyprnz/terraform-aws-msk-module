output "kafka_security_group_id" {
  description = "Kafka Client Instance Security Group ID"
  value       = "${aws_security_group.kafka_client_instance.id}"
}
