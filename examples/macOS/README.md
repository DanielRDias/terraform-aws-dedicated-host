# Mac OS Catalina Dedicated Host example

Configuration in this directory creates a dedicated host with a mac1.metal instance.

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
| dedicated-host | n/a |
| mac\_ami | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
