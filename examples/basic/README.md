# Basic Dedicated Host example

Configuration in this directory creates a dedicated host with no instances attached.

## Example source code

``` hcl
provider "aws" {
  region = "us-east-1"
}

module "dedicated-host" {
  source            = "DanielRDias/dedicated-host/aws"
  version           = "0.2.1"
  instance_type     = "c5.large"
  availability_zone = "us-east-1a"
  cf_stack_name     = "basic-stack"
}

output "dedicated_host_id" {
  description = "Dedicated Host ID"
  value       = module.dedicated-host.dedicated_host_id
}
```

## Usage

To run this example you need to execute:

```bash
terraform init
terraform plan
terraform apply
```

Note that this example may create resources which can cost money. Run `terraform destroy` when you don't need these resources.

## Terraform Docs

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

No provider.

## Inputs

No input.

## Outputs

| Name | Description |
|------|-------------|
| dedicated-host | Dedicated Host ID |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
