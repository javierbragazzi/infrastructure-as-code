
############ MAQUINAS VIRTUALES ############

###### NODO MASTER ######
resource "azurerm_linux_virtual_machine" "master" {
  name                            = "master-node"
  resource_group_name             = azurerm_resource_group.rg.name
  location                        = azurerm_resource_group.rg.location
  size                            = var.vm_master_size
  admin_username                  = var.ssh_user
  network_interface_ids           = [azurerm_network_interface.master.id]
  disable_password_authentication = true

  admin_ssh_key {
    username   = var.ssh_user
    public_key = file(var.public_key_path)
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  plan {
    name      = "centos-8-stream-free"
    product   = "centos-8-stream-free"
    publisher = "cognosys"
  }

  source_image_reference {
    publisher = "cognosys"
    offer     = "centos-8-stream-free"
    sku       = "centos-8-stream-free"
    version   = "22.03.28"
  }

  tags = var.tags_all_resources
}

###### NODOS WORKERS ######
resource "azurerm_linux_virtual_machine" "workers" {
  count                           = length(var.vm_worker_names)
  name                            = var.vm_worker_names[count.index]
  resource_group_name             = azurerm_resource_group.rg.name
  location                        = azurerm_resource_group.rg.location
  size                            = var.vm_worker_size
  admin_username                  = var.ssh_user
  network_interface_ids           = [azurerm_network_interface.workers[count.index].id]
  disable_password_authentication = true

  admin_ssh_key {
    username   = var.ssh_user
    public_key = file(var.public_key_path)
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  plan {
    name      = "centos-8-stream-free"
    product   = "centos-8-stream-free"
    publisher = "cognosys"
  }

  source_image_reference {
    publisher = "cognosys"
    offer     = "centos-8-stream-free"
    sku       = "centos-8-stream-free"
    version   = "22.03.28"
  }

  tags = var.tags_all_resources
}

###### NODO NFS ######
resource "azurerm_linux_virtual_machine" "nfs" {
  name                            = "nfs-node"
  resource_group_name             = azurerm_resource_group.rg.name
  location                        = azurerm_resource_group.rg.location
  size                            = var.vm_nfs_size
  admin_username                  = var.ssh_user
  network_interface_ids           = [azurerm_network_interface.nfs.id]
  disable_password_authentication = true

  admin_ssh_key {
    username   = var.ssh_user
    public_key = file(var.public_key_path)
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  plan {
    name      = "centos-8-stream-free"
    product   = "centos-8-stream-free"
    publisher = "cognosys"
  }

  source_image_reference {
    publisher = "cognosys"
    offer     = "centos-8-stream-free"
    sku       = "centos-8-stream-free"
    version   = "22.03.28"
  }

  tags = var.tags_all_resources
}

resource "azurerm_managed_disk" "data" {
  name                 = "storage-disk-nfs"
  location             = azurerm_resource_group.rg.location
  resource_group_name  = azurerm_resource_group.rg.name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = "10"
}

resource "azurerm_virtual_machine_data_disk_attachment" "data" {
  managed_disk_id    = azurerm_managed_disk.data.id
  virtual_machine_id = azurerm_linux_virtual_machine.nfs.id
  lun                = "1"
  caching            = "ReadWrite"
}