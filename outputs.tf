
output "instance_public_ip" {
  value       = aws_instance.vpn.public_ip
  description = "Endereco IP publico da instancia VPN"
}

output "instance_ssh_command" {
  value = "ssh -i ${var.private_key_path} ubuntu@${aws_instance.vpn.public_ip}"
}

output "instance_private_ip" {
  value       = aws_instance.vpn.private_ip
  description = "Endereco IP privado da instancia VPN"
}

output "instance_id" {
  value       = aws_instance.vpn.id
  description = "ID da instancia VPN"
}

output "instance_ssh_port" {
  value       = var.ssh_port
  description = "Porta SSH da instancia VPN"
}

output "instance_wireguard_port" {
  value       = var.wireguard_port
  description = "Porta WireGuard da instancia VPN"
}

output "instance_security_group_id" {
  value       = aws_security_group.vpn_sg.id
  description = "ID do grupo de seguranca da instancia VPN"
}

output "instance_security_group_tags" {
  value       = aws_security_group.vpn_sg.tags
  description = "Tags do grupo de seguranca da instancia VPN"
}

output "instance_public_dns" {
  value = aws_instance.vpn.public_dns
}

output "instance_private_dns" {
  value = aws_instance.vpn.private_dns
}

