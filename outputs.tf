output "dedicated_hosts_arn" {
  description = "The ARN of the Dedicated Host."
  value       = aws_ec2_host.this.arn
}

output "dedicated_host_id" {
  description = "Dedicated Host ID"
  value       = aws_ec2_host.this.id
}
