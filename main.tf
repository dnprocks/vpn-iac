provider "aws" {
  region     = "us-east-1"
  access_key = "test"
  secret_key = "test"

  endpoints {
    ec2 = "https://localhost.localstack.cloud:4566"
    sts = "https://localhost.localstack.cloud:4566"
  }
}

resource "aws_key_pair" "default" {
  key_name   = "vpn-key"
  public_key = file("~/.ssh/id_ed25519.pub")
}

resource "aws_security_group" "vpn_sg" {
  name        = "vpn-sg"
  description = "Security group for VPN"
  # vpc_id      = aws_vpc.default.id
  ingress {
    from_port   = 22
    to_port     = 22
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
  ami             = "ami-0c02fb55956c7d316"
  instance_type   = "t2.micro"
  key_name        = aws_key_pair.default.key_name
  security_groups = [aws_security_group.vpn_sg.name]

  tags = {
    Name = "VPN-Server"
  }
}
