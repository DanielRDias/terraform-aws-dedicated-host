# Terraform AWS Dedicated Host Module

Terraform module which creates EC2 dedicated host on AWS. Required for macOS instances (mac1.metal, mac2.metal)

## Usage

```hcl
module "dedicated-host" {
  source            = "DanielRDias/dedicated-host/aws"
  version           = "1.0.0"
  instance_type     = "c5.large"
  availability_zone = "us-east-1a"

  tags = {
    Name = "Terraform Mac"
  }
}
```

Full example for mac1.metal

```hcl
provider "aws" {
  region = "us-east-1"
}

module "dedicated-host" {
  source            = "DanielRDias/dedicated-host/aws"
  version           = "0.2.1"
  instance_type     = "mac1.metal"
  availability_zone = "us-east-1a"

  tags = {
    Name = "Terraform Mac"
  }
}

resource "aws_ec2_tag" "mac" {
  resource_id = module.dedicated-host.dedicated_hosts["HostID"]
  key         = "Name"
  value       = "Terraform Mac"
}

resource "aws_instance" "mac" {
  ami           = data.aws_ami.mac.id
  instance_type = "mac1.metal"
  host_id       = module.dedicated-host.dedicated_hosts["HostID"]
  subnet_id     = "subnet-xxxx" # Subnet ID in the same AZ as the dedicated host

  tags = {
    Name = "Terraform Mac"
  }
}

data "aws_ami" "mac" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn-ec2-macos-10.15*"]
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

output "dedicated-host" {
  value = module.dedicated-host.dedicated_hosts["HostID"]
}
```

**Note**: AWS has a limited capacity for dedicated hosts. Therefore, if terraform fails, check if AWS has availability in another availability zone.

## Examples

* [Basic Dedicated Host](https://github.com/DanielRDias/terraform-aws-dedicated-host/tree/main/examples/basic)
* [Dedicated Host with Mac Instance](https://github.com/DanielRDias/terraform-aws-dedicated-host/tree/main/examples/macOS)
* [Dedicated Host with Amazon Linux Instance](https://github.com/DanielRDias/terraform-aws-dedicated-host/tree/main/examples/amazon)

## Terraform Docs

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ec2_host.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_host) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_auto_placement"></a> [auto\_placement](#input\_auto\_placement) | (Optional) Indicates whether the host accepts any untargeted instance launches that match its instance type configuration, or if it only accepts Host tenancy instance launches that specify its unique host ID. Valid values: on, off. Default: on. | `string` | `"on"` | no |
| <a name="input_availability_zone"></a> [availability\_zone](#input\_availability\_zone) | The Availability Zone in which to allocate the Dedicated Host. | `string` | n/a | yes |
| <a name="input_host_recovery"></a> [host\_recovery](#input\_host\_recovery) | (Optional) Indicates whether to enable or disable host recovery for the Dedicated Host. Host recovery is disabled by default. | `string` | `"off"` | no |
| <a name="input_instance_family"></a> [instance\_family](#input\_instance\_family) | (Optional) Specifies the instance family to be supported by the Dedicated Hosts. If you specify an instance family, the Dedicated Hosts support multiple instance types within that instance family. Exactly one of instance\_family or instance\_type must be specified. | `string` | `"undefined"` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | (Optional) Specifies the instance type to be supported by the Dedicated Hosts. If you specify an instance type, the Dedicated Hosts support instances of the specified instance type only. Exactly one of instance\_family or instance\_type must be specified. | `string` | `"undefined"` | no |
| <a name="input_outpost_arn"></a> [outpost\_arn](#input\_outpost\_arn) | (Optional) The Amazon Resource Name (ARN) of the AWS Outpost on which to allocate the Dedicated Host. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A list of tags to associate with the CloudFormation stack. Does not propagate to the Dedicated Host. | `map(string)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dedicated_host_id"></a> [dedicated\_host\_id](#output\_dedicated\_host\_id) | Dedicated Host ID |
| <a name="output_dedicated_hosts_arn"></a> [dedicated\_hosts\_arn](#output\_dedicated\_hosts\_arn) | The ARN of the Dedicated Host. |
<!-- END_TF_DOCS -->