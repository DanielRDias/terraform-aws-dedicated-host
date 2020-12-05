provider "aws" {
  region = "us-east-1"
}

module "dedicated-host" {
  source            = "../../"
  instance_type     = "c5.large"
  availability_zone = "us-east-1a"
  cf_stack_name     = "basic-stack"
}

output "dedicated_host_id" {
  description = "Dedicated Host ID"
  value       = module.dedicated-host.dedicated_host_id
}
