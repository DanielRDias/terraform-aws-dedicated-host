# Mac OS Catalina Dedicated Host example

Configuration in this directory creates a dedicated host with a mac1.metal instance.

## Example source code

``` hcl
provider "aws" {
  region = "eu-central-1"
}

module "dedicated-host" {
  source            = "DanielRDias/dedicated-host/aws"
  version           = "1.0.0"
  instance_type     = "mac1.metal"
  availability_zone = "eu-central-1a"
}

resource "aws_instance" "mac" {
  ami           = data.aws_ami.mac.id
  instance_type = "mac1.metal"
  host_id       = module.dedicated-host.dedicated_host_id
  subnet_id     = "subnet-xxx" # Subnet ID in the same AZ as the dedicated host

  tags = {
    Name = "Terraform Mac"
  }
}

data "aws_ami" "mac" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn-ec2-macos-12*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"]
}

output "mac_ami" {
  value = data.aws_ami.mac.id
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

This example uses macOS Catalina 10.15, if you want to use a different OS you can update the `aws_ami` name filter to get a different OS version.

This example would get the AMI for macOS Mojave 10.14

```hcl
data "aws_ami" "mac" {
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn-ec2-macos-10.14*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["amazon"]
}
```

## Terraform Docs

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.35.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_dedicated-host"></a> [dedicated-host](#module\_dedicated-host) | ../../ | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_instance.mac](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_ami.mac](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dedicated_host_id"></a> [dedicated\_host\_id](#output\_dedicated\_host\_id) | n/a |
| <a name="output_mac_ami"></a> [mac\_ami](#output\_mac\_ami) | n/a |
<!-- END_TF_DOCS -->
