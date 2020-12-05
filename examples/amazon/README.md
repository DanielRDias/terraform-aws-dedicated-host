# Amazon Linux Dedicated Host example

Configuration in this directory creates a dedicated host with a amazon linux instance.

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
  cf_stack_name     = "amzn2-linux-stack"
}

resource "aws_instance" "amazon" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "c5.large"
  host_id       = module.dedicated-host.dedicated_host_id
  subnet_id     = "subnet-xxx" # Subnet ID in the same AZ as the dedicated host

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

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

No input.

## Outputs

| Name | Description |
|------|-------------|
| amazon\_linux\_ami | n/a |
| dedicated-host | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
