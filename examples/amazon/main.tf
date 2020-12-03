provider "aws" {
  region = "us-east-1"
}

module "dedicated-host" {
  source            = "../../"
  instance_type     = "c5.large"
  availability_zone = "us-east-1a"
  cf_stack_name     = "amzn2-linux-stack"
}

resource "aws_instance" "amazon" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "c5.large"
  host_id       = module.dedicated-host.dedicated_hosts["HostID"]
  subnet_id     = "subnet-058cf69f1cc6662e4" # Subnet ID in the same AZ as the dedicated host

  tags = {
    Name = "Terraform Amazon Linux"
  }
}

data "aws_ami" "amazon_linux" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name = "name"

    values = [
      "amzn2-ami-hvm*",
    ]
  }

  filter {
    name = "owner-alias"

    values = [
      "amazon",
    ]
  }
}

output "amazon_linux_ami" {
  value = data.aws_ami.amazon_linux.id
}

output "dedicated-host" {
  value = module.dedicated-host.dedicated_hosts["HostID"]
}
