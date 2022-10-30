variable "auto_placement" {
  description = "(Optional) Indicates whether the host accepts any untargeted instance launches that match its instance type configuration, or if it only accepts Host tenancy instance launches that specify its unique host ID. Valid values: on, off. Default: on."
  type        = string
  default     = "on"
}

variable "availability_zone" {
  description = "The Availability Zone in which to allocate the Dedicated Host."
  type        = string
}

variable "host_recovery" {
  description = "(Optional) Indicates whether to enable or disable host recovery for the Dedicated Host. Host recovery is disabled by default."
  type        = string
  default     = "off"
}

variable "instance_type" {
  description = "(Optional) Specifies the instance type to be supported by the Dedicated Hosts. If you specify an instance type, the Dedicated Hosts support instances of the specified instance type only. Exactly one of instance_family or instance_type must be specified."
  type        = string
  default     = "undefined"
}

variable "instance_family" {
  description = "(Optional) Specifies the instance family to be supported by the Dedicated Hosts. If you specify an instance family, the Dedicated Hosts support multiple instance types within that instance family. Exactly one of instance_family or instance_type must be specified."
  type        = string
  default     = "undefined"
}

variable "outpost_arn" {
  description = "(Optional) The Amazon Resource Name (ARN) of the AWS Outpost on which to allocate the Dedicated Host."
  type        = string
  default     = null
}

variable "tags" {
  description = "(Optional) A list of tags to associate with the CloudFormation stack. Does not propagate to the Dedicated Host."
  type        = map(string)
  default     = null
}
