output "dedicated_hosts" {
  description = "Dedicated Host ID"
  value       = aws_cloudformation_stack.dedicated_hosts.outputs
}
output "cf_stack_id" {
  description = "Cloud Formation Stack ID"
  value       = aws_cloudformation_stack.dedicated_hosts.id
}
