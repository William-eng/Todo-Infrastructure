output "public_ip" {
  description = "Public IP address of the instance"
  value       = aws_instance.app_server.public_ip
}
