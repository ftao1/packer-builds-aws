# Packer Template for Building an AMI
# This template uses the amazon-ebs builder to create an Ubuntu-based AMI.
# It includes a provisioner to run a script that updates the system.
# Created by: F.Tao
# Date: 13 June 2024

packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.8"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

# VARIABLES BLOCK

variable "aws_instance_type" {
  type    = string
  default = "t2.micro"
}

variable "build_name" {
  type = string
  default = "ubuntu-packer-ami"
}

# LOCALS BLOCK

locals {
  timestamp = regex_replace(timestamp(), "[- TZ:]", "")
  formatted_date   = formatdate("YYYY-MM-DD hh:mm ZZZ", timestamp())
}

# SOURCE BLOCK

source "amazon-ebs" "ubuntu" {

  ami_name        = "learn-packer-linux-aws-${local.timestamp}"
  ami_description = "Created on ${local.formatted_date} by Unix"
  instance_type   = var.aws_instance_type
  ssh_username    = "ubuntu"

  source_ami_filter {
    filters = {
      name                = "ubuntu/images/*ubuntu-jammy-22.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }
}

# BUILD BLOCK

build {
  name = var.build_name
  sources = [
    "source.amazon-ebs.ubuntu"
  ]

  provisioner "shell" {
    script = "scripts/update.sh"
  }
}
