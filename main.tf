module "ansible-infra" {
  source         = "../modules"
  new_rg = var.new_rg
  existing_rg = var.existing_rg
  location = var.location
  existing_vnet = var.existing_vnet
  new_vnet = var.new_vnet
  controller-subnet = var.controller-subnet
  web-subnet = var.web-subnet
  db-subnet = var.db-subnet
  new-controller-subnet = var.new-controller-subnet
  new-db-subnet = var.new-db-subnet
  new-web-subnet = var.new-web-subnet
  address_prefixes = var.address_prefixes
  address_prefixes2 = var.address_prefixes2
  address_prefixes3 = var.address_prefixes3
  controller-nic = var.controller-nic
  web-nic = var.web-nic
  db-nic = var.db-nic
  controller-vm-name = var.controller-vm-name
  web-vm-name = var.web-vm-name
  db-vm-name = var.db-vm-name

}























# module "kola-vm-2" {
#   source         = "../modules"
#   resource-group = var.resource-group
#   location       = var.location
#   subnet         = var.subnet
#   nic            = var.nic2
#   vm-name        = var.vm-name2
#   user-name      = var.user-name
#   vnet           = var.vnet
#   ipconfig       = var.ipconfig2
# }

# module "kola-vm-3" {
#   source         = "../modules"
#   resource-group = var.resource-group
#   location       = var.location
#   subnet         = var.subnet
#   nic            = var.nic3
#   vm-name        = var.vm-name3
#   user-name      = var.user-name
#   vnet           = var.vnet
#   ipconfig       = var.ipconfig3
# }

