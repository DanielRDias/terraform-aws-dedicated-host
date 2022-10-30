provider "aws" {
  region = "us-east-1"
}

module "dedicated-host" {
  source            = "../../"
  instance_type     = "t3.nano"
  availability_zone = "us-east-1b"
}

resource "aws_instance" "amazon" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t3.nano"
  host_id       = module.dedicated-host.dedicated_host_id
  subnet_id     = "subnet-xxx" # Subnet ID in the same AZ as the dedicated host

  credit_specification {
    cpu_credits = "standard"
  }

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

output "dedicated_host_id" {
  value = module.dedicated-host.dedicated_host_id
}
