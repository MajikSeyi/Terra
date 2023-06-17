####Create resource group or reference existing
resource "azurerm_resource_group" "resource-group" {
  name     = var.new_rg
  location = var.location
  count    = length(data.azurerm_resource_group.resource-group) == 0 ? 1 : 0
}

data "azurerm_resource_group" "resource-group" {
  count = var.existing_rg != "" ? 1 : 0
  name  = var.existing_rg
}

####Create vnet or reference existing
resource "azurerm_virtual_network" "vnet" {
  name                = var.new_vnet
  address_space       = ["10.0.0.0/8"]
  resource_group_name = var.existing_rg == "" ? azurerm_resource_group.resource-group[0].name : data.azurerm_resource_group.resource-group[0].name
  location            = var.location
  count               = length(data.azurerm_virtual_network.vnet) == 0 ? 1 : 0
}

data "azurerm_virtual_network" "vnet" {
  count               = var.existing_vnet != "" ? 1 : 0
  name                = var.existing_vnet
  resource_group_name = var.existing_rg
}

####Create ansible controller subnet or reference existing subnet

data "azurerm_subnet" "controller-subnet" {
  count                = var.controller-subnet == "" ? 0 : 1
  name                 = var.controller-subnet
  resource_group_name  = var.existing_rg
  virtual_network_name = var.existing_vnet
}

resource "azurerm_subnet" "controller" {
  name                 = var.new-controller-subnet
  resource_group_name  = var.existing_rg == "" ? azurerm_resource_group.resource-group[0].name : data.azurerm_resource_group.resource-group[0].name
  count                = length(data.azurerm_subnet.controller-subnet) == 0 ? 1 : 0
  virtual_network_name = var.existing_vnet == "" ? azurerm_virtual_network.vnet[0].name : data.azurerm_virtual_network.vnet[0].name
  address_prefixes     = var.address_prefixes
}


####Create ansible web target subnet or reference existing subnet

data "azurerm_subnet" "web-subnet" {
  count                = var.web-subnet == "" ? 0 : 1
  name                 = var.web-subnet
  resource_group_name  = var.existing_rg
  virtual_network_name = var.existing_vnet
}

resource "azurerm_subnet" "web" {
  name                 = var.new-web-subnet
  resource_group_name  = var.existing_rg == "" ? azurerm_resource_group.resource-group[0].name : data.azurerm_resource_group.resource-group[0].name
  count                = length(data.azurerm_subnet.web-subnet) == 0 ? 1 : 0
  virtual_network_name = var.existing_vnet == "" ? azurerm_virtual_network.vnet[0].name : data.azurerm_virtual_network.vnet[0].name

  address_prefixes = var.address_prefixes2
}

####Create ansible db target subnet or reference existing subnet

data "azurerm_subnet" "db-subnet" {
  count                = var.db-subnet == "" ? 0 : 1
  name                 = var.db-subnet
  resource_group_name  = var.existing_rg
  virtual_network_name = var.existing_vnet
}

resource "azurerm_subnet" "db" {
  name                 = var.new-db-subnet
  resource_group_name  = var.existing_rg == "" ? azurerm_resource_group.resource-group[0].name : data.azurerm_resource_group.resource-group[0].name
  count                = length(data.azurerm_subnet.db-subnet) == 0 ? 1 : 0
  address_prefixes     = var.address_prefixes3
  virtual_network_name = var.existing_vnet == "" ? azurerm_virtual_network.vnet[0].name : data.azurerm_virtual_network.vnet[0].name

}

#CREATE ANSIBLE CONTROLLER LINUX VM
resource "azurerm_network_interface" "int001" {
  name                = var.controller-nic
  location            = var.location
  resource_group_name = var.existing_rg == "" ? azurerm_resource_group.resource-group[0].name : data.azurerm_resource_group.resource-group[0].name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.controller-subnet != "" ? data.azurerm_subnet.controller-subnet[0].id : azurerm_subnet.controller[0].id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "controller-vm" {
  name                            = var.controller-vm-name
  resource_group_name             = var.existing_rg == "" ? azurerm_resource_group.resource-group[0].name : data.azurerm_resource_group.resource-group[0].name
  location                        = var.location
  size                            = "Standard_F2"
  admin_username                  = var.user-name
  admin_password                  = var.password
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.int001.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }
}

#CREATE WEB NODE 001 LINUX VM
resource "azurerm_network_interface" "int002" {
  name                = var.web-nic
  location            = var.location
  resource_group_name = var.existing_rg == "" ? azurerm_resource_group.resource-group[0].name : data.azurerm_resource_group.resource-group[0].name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.web-subnet != "" ? data.azurerm_subnet.web-subnet[0].id : azurerm_subnet.web[0].id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "web-vm" {
  name                            = var.web-vm-name
  resource_group_name             = var.existing_rg == "" ? azurerm_resource_group.resource-group[0].name : data.azurerm_resource_group.resource-group[0].name
  location                        = var.location
  size                            = "Standard_F2"
  admin_username                  = var.user-name
  admin_password                  = var.password
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.int002.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }
}

#CREATE DB NODE 001 LINUX VM
resource "azurerm_network_interface" "int003" {
  name                = var.db-nic
  location            = var.location
  resource_group_name = var.existing_rg == "" ? azurerm_resource_group.resource-group[0].name : data.azurerm_resource_group.resource-group[0].name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.db-subnet != "" ? data.azurerm_subnet.db-subnet[0].id : azurerm_subnet.db[0].id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "db-vm" {
  name                            = var.db-vm-name
  resource_group_name             = var.existing_rg == "" ? azurerm_resource_group.resource-group[0].name : data.azurerm_resource_group.resource-group[0].name
  location                        = var.location
  size                            = "Standard_F2"
  admin_username                  = var.user-name
  admin_password                  = var.password
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.int003.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }
}
