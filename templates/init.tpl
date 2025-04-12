#!/bin/bash
set -eux
# Update and upgrade system packages
apt-get update -y
apt-get upgrade -y

echo "EC2 configured successfully."