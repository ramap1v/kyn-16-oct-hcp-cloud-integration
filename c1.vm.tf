resource "azurerm_linux_virtual_machine" "web_vm" {
name = "${local.resource_name_prefix}-vm" #sap-dev-vnet-gopal
  #this vnet need to be mapped with rg name and location
  location            = azurerm_resource_group.kyn-rg.location
  resource_group_name = azurerm_resource_group.kyn-rg.name
  size                = "Standard_D2s_v3"
  admin_username      = "azureuser"
  network_interface_ids = [
    azurerm_network_interface.web_nic.id,
  ]

  admin_ssh_key {
    username   = "azureuser"
    public_key = file("${path.module}/ssh-keys/terraform-azure.pem.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  tags = local.project_tags
  #we need to run the startup script 
  custom_data = filebase64("${path.module}/app/app.sh")
}