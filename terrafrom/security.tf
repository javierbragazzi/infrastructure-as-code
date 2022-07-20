
resource "azurerm_network_security_group" "master" {
  name                = "master-network-security-group"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "IngressController"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = var.ingress_controller_port
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = var.tags_all_resources
}

resource "azurerm_network_security_group" "workers" {
  name                = "workers-network-security-group"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

    security_rule {
    name                       = "Port_32593"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "32593"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = var.tags_all_resources
}

resource "azurerm_network_security_group" "nfs" {
  name                = "nfs-network-security-group"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = var.tags_all_resources
}

resource "azurerm_network_interface_security_group_association" "master" {
  network_interface_id      = azurerm_network_interface.master.id
  network_security_group_id = azurerm_network_security_group.master.id
}

resource "azurerm_network_interface_security_group_association" "workers" {
  network_interface_id      = azurerm_network_interface.workers[count.index].id
  count                     = length(var.vm_worker_names)
  network_security_group_id = azurerm_network_security_group.workers.id
}

resource "azurerm_network_interface_security_group_association" "nfs" {
  network_interface_id      = azurerm_network_interface.nfs.id
  network_security_group_id = azurerm_network_security_group.nfs.id
}