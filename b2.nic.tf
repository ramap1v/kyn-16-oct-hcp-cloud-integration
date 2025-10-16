resource "azurerm_network_interface" "web_nic" {
  name = "${local.resource_name_prefix}-nic" #sap-dev-vnet-gopal
  #this vnet need to be mapped with rg name and location
  location            = azurerm_resource_group.kyn-rg.location
  resource_group_name = azurerm_resource_group.kyn-rg.name
  #this is the nic ip configuration
  ip_configuration {
    name                          = "internal"
    #this subnet will provide me nsg and private ip also 
    subnet_id                     = azurerm_subnet.web_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.web_publicip.id 
  }
}