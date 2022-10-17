provider "aws" {
  region = "eu-central-1"
}

module "dedicated-host" {
  source            = "../../"
  instance_type     = "mac1.metal"
  availability_zone = "eu-central-1a"
  cf_stack_name     = "mac-stack"
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
