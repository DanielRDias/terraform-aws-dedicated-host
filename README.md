# terraform-aws-dedicated-host

Terraform module which creates EC2 dedicated host on AWS. Required for macOS instances (mac1.metal)

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
| host\_recovery | Indicates whether to enable or disable host recovery for the Dedicated Host. Host recovery is disabled by default. | `string` | `"off"` | no |
| instance\_type | Specifies the instance type to be supported by the Dedicated Hosts. If you specify an instance type, the Dedicated Hosts support instances of the specified instance type only. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| cf\_stack\_id | Cloud Formation Stack ID |
| dedicated\_hosts | Dedicated Host ID |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->