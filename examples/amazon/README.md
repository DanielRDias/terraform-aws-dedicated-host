# Amazon Linux Dedicated Host example

Configuration in this directory creates a dedicated host with a amazon linux instance.

## Example source code

``` hcl
provider "aws" {
  region = "us-east-1"
}

module "dedicated-host" {
  source            = "DanielRDias/dedicated-host/aws"
  version           = "1.0.0"
  instance_type     = "c5.large"
  availability_zone = "us-east-1a"
}

resource "aws_instance" "amazon" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "c5.large"
  host_id       = module.dedicated-host.dedicated_host_id
  subnet_id     = "subnet-xxx" # Subnet ID in the same AZ as the dedicated host

  credit_specification {
    cpu_credits = "standard"
  }

  tags = {
    Name = "Terraform Amazon Linux"
  }
}

data "aws_ami" "amazon_linux" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name = "name"

    values = [
      "amzn2-ami-hvm*",
    ]
  }

  filter {
    name = "owner-alias"

    values = [
      "amazon",
    ]
  }
}

output "amazon_linux_ami" {
  value = data.aws_ami.amazon_linux.id
}

output "dedicated_host_id" {
  value = module.dedicated-host.dedicated_host_id
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

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.37.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_dedicated-host"></a> [dedicated-host](#module\_dedicated-host) | ../../ | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_instance.amazon](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_ami.amazon_linux](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_amazon_linux_ami"></a> [amazon\_linux\_ami](#output\_amazon\_linux\_ami) | n/a |
| <a name="output_dedicated_host_id"></a> [dedicated\_host\_id](#output\_dedicated\_host\_id) | n/a |
<!-- END_TF_DOCS -->