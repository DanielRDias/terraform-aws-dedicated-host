provider "aws" {
  region = "us-east-1"
}

module "dedicated-host" {
  source            = "../../"
  instance_type     = "mac1.metal"
  availability_zone = "us-east-1a"
  cf_stack_name     = "mac-stack"
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
