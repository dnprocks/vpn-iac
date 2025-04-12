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

  tags = {
    Name = "VPN-SG"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_wireguard" {
  security_group_id = aws_security_group.vpn_sg.id
  from_port         = var.wireguard_port
  to_port           = var.wireguard_port
  ip_protocol       = "udp"
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.vpn_sg.id
  from_port         = var.ssh_port
  to_port           = var.ssh_port
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_vpc_security_group_egress_rule" "allow_all_outbound" {
  security_group_id = aws_security_group.vpn_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_instance" "vpn" {
  ami             = var.ami
  instance_type   = var.instance_type
  key_name        = aws_key_pair.default.key_name
  security_groups = [aws_security_group.vpn_sg.name]

  user_data = templatefile("${path.module}/templates/init.tpl", {})

  tags = {
    Name = "VPN-Server"
  }
}
