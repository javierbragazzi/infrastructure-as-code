###### RED VIRTUAL ######
resource "azurerm_virtual_network" "vnet" {
  name                = var.network_name
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  tags = var.tags_all_resources
}

###### SUBRED ######
resource "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

###### IP's PUBLICAS ######
resource "azurerm_public_ip" "master" {
  name                = "master-ip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
  sku                 = "Basic"

  tags = var.tags_all_resources
}

resource "azurerm_public_ip" "workers" {
  count               = length(var.vm_worker_names)
  name                = "${var.vm_worker_names[count.index]}-ip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
  sku                 = "Basic"

  tags = var.tags_all_resources
}

resource "azurerm_public_ip" "nfs" {
  name                = "nfs-ip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
  sku                 = "Basic"

  tags = var.tags_all_resources
}

###### PLACAS DE RED ######
resource "azurerm_network_interface" "master" {
  name                = "master-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "master-ip-conf"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.master.id
  }

  tags = var.tags_all_resources
}

resource "azurerm_network_interface" "workers" {
  count               = length(var.vm_worker_names)
  name                = "${var.vm_worker_names[count.index]}-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "${var.vm_worker_names[count.index]}-ip-conf"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.workers[count.index].id
  }

  tags = var.tags_all_resources
}

resource "azurerm_network_interface" "nfs" {
  name                = "nfs-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "nfs-ip-conf"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.nfs.id
  }

  tags = var.tags_all_resources
}