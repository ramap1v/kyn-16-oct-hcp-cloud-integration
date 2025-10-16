#public ip
#we will create a public ip
resource "azurerm_public_ip" "jump_publicip" {
 name = "${local.resource_name_prefix}-jump-publicip" #sap-dev-vnet-gopal
  #this vnet need to be mapped with rg name and location
  location            = azurerm_resource_group.kyn-rg.location
  resource_group_name = azurerm_resource_group.kyn-rg.name
  allocation_method   = "Static"
  sku = "Standard" 

  tags = local.project_tags
}

#nic
resource "azurerm_network_interface" "jump_nic" {
 
  name = "${local.resource_name_prefix}-nic-jump" #sap-dev-vnet-gopal
  #this vnet need to be mapped with rg name and location
  location            = azurerm_resource_group.kyn-rg.location
  resource_group_name = azurerm_resource_group.kyn-rg.name
  #this is the nic ip configuration
  ip_configuration {
    name                          = "internal"
    #this subnet will provide me nsg and private ip also 
    subnet_id                     = azurerm_subnet.jump_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.jump_publicip.id 
  }
}

#jump vm
resource "azurerm_windows_virtual_machine" "windowsvm" {
  name                = "win-jump" #change the name of the vm 
  resource_group_name = azurerm_resource_group.kyn-rg.name #change the rg name 
  location            = azurerm_resource_group.kyn-rg.location #change the location
  size                = "Standard_D2s_v3"
  admin_username      = "adminuser"
  admin_password      = "P@$$w0rd1234!"
  network_interface_ids = [
    azurerm_network_interface.jump_nic.id, #change the label of the nic card
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  #change the windows image from server to windows 11 desktop

  source_image_reference {
    publisher = "microsoftwindowsdesktop"
    offer     = "windows-11"
    sku       = "win11-24h2-pro"
    version   = "latest"
  }
}

