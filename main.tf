locals {
  is_family_type = var.instance_family != "undefined" ? true : false
}

resource "aws_ec2_host" "this" {
  auto_placement    = var.auto_placement
  availability_zone = var.availability_zone
  host_recovery     = var.host_recovery
  instance_family   = local.is_family_type ? var.instance_family : null
  instance_type     = local.is_family_type ? null : var.instance_type
  outpost_arn       = var.outpost_arn
  tags              = var.tags
}
