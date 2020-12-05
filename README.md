# Terraform AWS Dedicated Host Module

Terraform module which creates EC2 dedicated host on AWS. Required for macOS instances (mac1.metal)

## Usage

```hcl
module "dedicated-host" {
  source            = "DanielRDias/dedicated-host/aws"
  version           = "0.2.1"
  instance_type     = "c5.large"
  availability_zone = "us-east-1a"
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

**Note**: AWS has a limited capacity for dedicated hosts. If terraform times out and fails to create the dedicated host, the cloudformation stack will stay in your account until you do `terraform destroy`.
Check <https://aws.amazon.com/premiumsupport/knowledge-center/cloudformation-stack-stuck-progress/> for more details.

## Examples

* [Basic Dedicated Host](https://github.com/DanielRDias/terraform-aws-dedicated-host/tree/main/examples/basic)
* [Dedicated Host with Mac Instance](https://github.com/DanielRDias/terraform-aws-dedicated-host/tree/main/examples/macOS)
* [Dedicated Host with Amazon Linux Instance](https://github.com/DanielRDias/terraform-aws-dedicated-host/tree/main/examples/amazon)

## Terraform Docs

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| auto\_placement | Indicates whether the host accepts any untargeted instance launches that match its instance type configuration, or if it only accepts Host tenancy instance launches that specify its unique host ID. | `string` | `"on"` | no |
| availability\_zone | The Availability Zone in which to allocate the Dedicated Host. | `string` | n/a | yes |
| cf\_stack\_name | Dedicated host CloudFormation stack name. It can include letters (A-Z and a-z), numbers (0-9), and dashes (-). | `string` | `"dedicated-hosts-stack"` | no |
| host\_recovery | Indicates whether to enable or disable host recovery for the Dedicated Host. Host recovery is disabled by default. | `string` | `"off"` | no |
| instance\_type | Specifies the instance type to be supported by the Dedicated Hosts. If you specify an instance type, the Dedicated Hosts support instances of the specified instance type only. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| cf\_stack\_id | Cloud Formation Stack ID |
| dedicated\_host\_id | Dedicated Host ID |
| dedicated\_hosts | Maps with the dedicated hosts IDs |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
