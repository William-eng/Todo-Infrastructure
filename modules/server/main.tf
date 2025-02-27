provider "aws" {
  region = var.region
}

# Define the EC2 instance
resource "aws_instance" "app_server" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = aws_key_pair.deployer.key_name
    root_block_device {
    volume_size           = 30
    volume_type           = "gp3"
    delete_on_termination = true
    tags = {
      Name = "app-server-root-volume"
    }

  }

  security_groups = [aws_security_group.app_sg.name]
  tags = {
    Name = "AppServer"
  }
 provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("~/.ssh/id_rsa")  # Path to your private key
      host        = aws_instance.app_server.public_ip
    }

    inline = [
      "sudo apt update",
      "git clone https://github.com/William-eng/To-do-App.git",
    ]
  }
}
resource "aws_route53_record" "todo_app_dns" {
  zone_id = var.hosted_zone_id
  name    = var.domain
  type    = "A"
  ttl     = 300
  records = [aws_instance.app_server.public_ip]
  allow_overwrite = true
}
resource "aws_key_pair" "deployer" {
  key_name   = "worker-key"
  public_key = file("~/.ssh/id_rsa.pub")  # Path to your public key
}


# Add wildcard CNAME record
resource "aws_route53_record" "wildcard_dns" {
  zone_id = var.hosted_zone_id
  name    = "*.${var.domain}"
  type    = "A"
  ttl     = 300
  records = [aws_instance.app_server.public_ip]
  allow_overwrite = true
}


# Security Group to allow HTTP, HTTPS, and SSH
resource "aws_security_group" "app_sg" {
  name_prefix = "app_sg"
  description = "Allow inbound traffic to app server"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
    ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
# resource "local_file" "ansible_inventory" {

#   content = <<EOT
# [all]
# ${aws_instance.app_server.public_ip} ansible_user=ubuntu ansible_private_key_file=~/worker.pem
# EOT
#   filename = "ansible/inventory"
# }

# resource "null_resource" "run_ansible" {

#   provisioner "local-exec" {
#     # Add a small delay to ensure instance is fully ready
#     command = <<-EOT
#       sleep 30 && \
#       ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ansible/inventory ansible/playbook.yml
#     EOT
#   }
# }
  


output "instance_ip" {
  value = aws_instance.app_server.public_ip
}
