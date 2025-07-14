
# terraform.tf ---------------------------
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.2.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.7.2"
    }
  }
}

# providers.tf --------------------------
provider "aws" {
  region = var.region
}

# variables.tf ------------------------------
variable "region" {
  type    = string
  default = "ap-south-1"
}
variable "environment" {
  type    = string
  default = "project-01"
}

variable "ami_id" {
  type    = string
  default = "ami-0d03cb826412c6b0f"
}
variable "instance_type" {
  type    = string
  default = "t2.micro"
}

# vpc.tf ---------------------------
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name        = "${var.environment}-vpc"
    Environment = var.environment
  }
}

resource "aws_subnet" "main_subnet" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.${count.index}.0/24"
  count      = 2
  tags = {
    Name        = "${var.environment}-subnet-${count.index}"
    Environment = var.environment
  }
}

# ec2.tf file  ----------------------------
resource "aws_instance" "main" {
  ami           = var.ami_id
  instance_type = var.instance_type
  count         = 4
  #   subnet_id     = aws_subnet.main_subnet.id   # -> for single subnet 
  #   subnet_id = element(aws_subnet.main_subnet[*].id, count.index%2) # -> for multi subnet - 0, 1 | but after 3rd 
  #   0%2 = 0
  #   1%2 = 1
  #   2%2 = 0
  #   3%2 = 1

  subnet_id = aws_subnet.main_subnet[floor(count.index / 2)].id # take dynamic value of subnet for the instance
  tags = {
    Name        = "${var.environment}-instance-${count.index}"
    Environment = var.environment
  }
}

# outputs.tf ---------------------------------

output "subnet_id" {
  value = aws_subnet.main_subnet[*].id
}

output "instance_private_ip" {
  value = aws_instance.main[*].private_ip
}


output "instance_subnet_id" {
  value = aws_instance.main[*].subnet_id
}

output "instance_details" {
  value = {
    for i in aws_instance.main :
    i.tags["Name"] => {
      private_ip = i.private_ip
      subnet_id  = i.subnet_id
    }
  }
}
