variable "instance_type" {
  description = "Specifies the instance type to be supported by the Dedicated Hosts. If you specify an instance type, the Dedicated Hosts support instances of the specified instance type only."
  type        = string
}

variable "availability_zone" {
  description = "The Availability Zone in which to allocate the Dedicated Host."
  type        = string
}

variable "auto_placement" {
  description = "Indicates whether the host accepts any untargeted instance launches that match its instance type configuration, or if it only accepts Host tenancy instance launches that specify its unique host ID."
  type        = string
  default     = "on"
}

variable "host_recovery" {
  description = "Indicates whether to enable or disable host recovery for the Dedicated Host. Host recovery is disabled by default."
  type        = string
  default     = "off"
}

variable "cf_stack_name" {
  description = "Dedicated host CloudFormation stack name. It can include letters (A-Z and a-z), numbers (0-9), and dashes (-)."
  type        = string
  default     = "dedicated-hosts-stack"
}
