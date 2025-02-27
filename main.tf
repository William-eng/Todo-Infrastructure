module "server" {
  source = "./modules/server"

  instance_type       = var.instance_type
  ami_id                = var.ami
  security_group_name = var.security_group_name
  domain         = var.domain
  hosted_zone_id = var.hosted_zone_id
  key_name       = var.key_name
}
# resource "local_file" "ansible_inventory" {
#   content = templatefile(
#     "${path.module}/templates/inventory.tpl",
#     { public_ip = module.server.public_ip }
#   )
#   filename = "${path.module}/inventory.ini"
# }
# resource "null_resource" "ansible_playbook" {
#   depends_on = [local_file.ansible_inventory]

#   provisioner "local-exec" {
#     command = "ansible-playbook -i ${local_file.ansible_inventory.filename} playbook.yml"
#   }
# }
resource "local_file" "ansible_inventory" {
  content = templatefile(
    "${path.module}/templates/inventory.tpl",
    { public_ip = module.server.public_ip }
  )
  filename = "${path.module}/inventory.ini"
}

resource "null_resource" "ansible_playbook" {
  depends_on = [local_file.ansible_inventory]

  provisioner "local-exec" {
    command = "sleep 60 && ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ${local_file.ansible_inventory.filename} playbook.yml"
  }
}