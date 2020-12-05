output "dedicated_hosts" {
  description = "Maps with the dedicated hosts IDs"
  value       = aws_cloudformation_stack.dedicated_hosts.outputs
}

output "dedicated_host_id" {
  description = "Dedicated Host ID"
  value       = length(aws_cloudformation_stack.dedicated_hosts.outputs) > 0 ? aws_cloudformation_stack.dedicated_hosts.outputs["HostID"] : ""
}

output "cf_stack_id" {
  description = "Cloud Formation Stack ID"
  value       = aws_cloudformation_stack.dedicated_hosts.id
}
