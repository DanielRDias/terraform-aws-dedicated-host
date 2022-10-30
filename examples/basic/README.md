# Basic Dedicated Host example

Configuration in this directory creates a dedicated host with no instances attached.

## Example source code

``` hcl
provider "aws" {
  region = "us-east-1"
}

module "dedicated-host" {
  source            = "DanielRDias/dedicated-host/aws"
  version           = "1.0.0"
  instance_type     = "t3.nano"
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

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_dedicated-host"></a> [dedicated-host](#module\_dedicated-host) | ../../ | n/a |

## Resources

No resources.

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dedicated_host_id"></a> [dedicated\_host\_id](#output\_dedicated\_host\_id) | Dedicated Host ID |
<!-- END_TF_DOCS -->