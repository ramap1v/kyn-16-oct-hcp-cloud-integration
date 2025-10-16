resource "azurerm_subnet" "jump_subnet" {
  name                 = "${local.resource_name_prefix}-${var.jump_subnet_name}" #sap-dev-web-subnet
  resource_group_name  = azurerm_resource_group.kyn-rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.jump_subnet_prefix
}

resource "azurerm_network_security_group" "jump_nsg" {
  name = "${local.resource_name_prefix}-nsg-jump" #sap-dev-vnet-gopal
  #this vnet need to be mapped with rg name and location
  location            = azurerm_resource_group.kyn-rg.location
  resource_group_name = azurerm_resource_group.kyn-rg.name



  tags = local.project_tags
}

#this nsg need to be attache with websubnet
resource "azurerm_subnet_network_security_group_association" "jump_nsg_association" {
  subnet_id                 = azurerm_subnet.jump_subnet.id
  network_security_group_id = azurerm_network_security_group.jump_nsg.id
}

#inside nsg we need to create rules. open ports
#when we are opening port we need to give priority
#we are going open port 22 80 443
locals {
  jump_nsg_rule_inbound = { #this is the name

    "110" : "22", #expression in key value format priority : portnumber
    "120" : "3389"
    
  }
}
resource "azurerm_network_security_rule" "jump_nsg_rule" {
  depends_on = [  azurerm_network_security_group.jump_nsg ]
    for_each = local.jump_nsg_rule_inbound
  name                        = "Rule_port_${each.value}" #Rule_port_22 80
  priority                    = each.key #110 120
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = each.value #22 80
  source_address_prefix       = "*"
  destination_address_prefix  = "*" #12.12.12.12
  resource_group_name         = azurerm_resource_group.kyn-rg.name
  network_security_group_name = azurerm_network_security_group.jump_nsg.name
}

