resource "azurerm_public_ip" "web_publicip" {
 name = "${local.resource_name_prefix}-publicip" #sap-dev-vnet-gopal
  #this vnet need to be mapped with rg name and location
  location            = azurerm_resource_group.kyn-rg.location
  resource_group_name = azurerm_resource_group.kyn-rg.name
  allocation_method   = "Static"
  sku = "Standard" 

  tags = local.project_tags
}