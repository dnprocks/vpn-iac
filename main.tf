provider "aws" {
  region                   = var.region
  shared_config_files      = ["~/.aws/config"]
  shared_credentials_files = ["~/.aws/credentials"]
  profile                  = "localstack"
  # skip_credentials_validation = true
  # skip_metadata_api_check     = true
  # skip_requesting_account_id  = true

  endpoints {
    sts = var.sts_endpoint
    ec2 = var.ec2_endpoint
  }
}

resource "aws_key_pair" "default" {
  key_name   = "vpn-key"
  public_key = file(var.public_key_path)
}

resource "aws_security_group" "vpn_sg" {
  name        = "vpn-sg"
  description = "Security group for VPN"
  # vpc_id      = aws_vpc.default.id
  ingress {
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "VPN-SG"
  }
}

resource "aws_instance" "vpn" {
  ami             = var.ami
  instance_type   = var.instance_type
  key_name        = aws_key_pair.default.key_name
  security_groups = [aws_security_group.vpn_sg.name]

  tags = {
    Name = "VPN-Server"
  }
}
