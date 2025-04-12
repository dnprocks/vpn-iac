variable "region" {
  description = "The AWS region to deploy the resources in"
  default     = "us-east-1"
}

variable "ami" {
  description = "The AMI ID to use for the instance"
  default     = "ami-0c02fb55956c7d316" # Ubuntu 22.04 Free Tier in us-east-1
}

variable "instance_type" {
  description = "The type of instance to create"
  default     = "t2.micro"
}

variable "access_key" {
  description = "value of the access key"
  default     = "test"
}

variable "secret_key" {
  description = "value of the secret key"
  default     = "test"
}

variable "ec2_endpoint" {
  description = "The endpoint for the EC2 service"
  default     = "https://localhost.localstack.cloud:4566"
}

variable "sts_endpoint" {
  description = "The endpoint for the STS service"
  default     = "https://localhost.localstack.cloud:4566"
}

variable "public_key_path" {
  description = "The path to the public key file"
  default     = "~/.ssh/id_ed25519.pub"
}

variable "ssh_port" {
  description = "The port for SSH access"
  type        = number
  default     = 22
}

variable "wireguard_port" {
  description = "The port for SSH access"
  type        = number
  default     = 51820
}
