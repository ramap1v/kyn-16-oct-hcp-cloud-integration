#we will create a public ip
resource "azurerm_public_ip" "lb_publicip" {
 name = "${local.resource_name_prefix}-publicip" #sap-dev-vnet-gopal
  #this vnet need to be mapped with rg name and location
  location            = azurerm_resource_group.kyn-rg.location
  resource_group_name = azurerm_resource_group.kyn-rg.name
  allocation_method   = "Static"
  sku = "Standard" 

  tags = local.project_tags
}

#lets create the lb and attach the public ip with the lb
resource "azurerm_lb" "web_lb" {
  name = "${local.resource_name_prefix}-lb" #sap-dev-vnet-gopal
  #this vnet need to be mapped with rg name and location
  location            = azurerm_resource_group.kyn-rg.location
  resource_group_name = azurerm_resource_group.kyn-rg.name
  sku = "Standard"
  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    #this is the place we need to attach the public ip
    public_ip_address_id = azurerm_public_ip.lb_publicip.id
  }
}

#we will create the backend pool
resource "azurerm_lb_backend_address_pool" "example" {
  loadbalancer_id = azurerm_lb.web_lb.id
  name            = "BackEndAddressPool"
}
#healtch checkup
resource "azurerm_lb_probe" "web_lb_probe" {
  loadbalancer_id = azurerm_lb.web_lb.id 
  name = "frontendprobe"
  protocol = "Tcp"
  port = 80
  interval_in_seconds = 30
  number_of_probes = 2 #which is 1 min if any of the server do not respond in this time it will stop sending the traffic
}

#we need to create the load balancer rule 
resource "azurerm_lb_rule" "web_lb_rule" {
  loadbalancer_id = azurerm_lb.web_lb.id 
  name = "HTTP"
  protocol = "Tcp"
  frontend_port = 80 #the http traffice to lb
  backend_port = 80 #lb to nic card 8080
  frontend_ip_configuration_name = azurerm_lb.web_lb.frontend_ip_configuration[0].name 
  backend_address_pool_ids = [azurerm_lb_backend_address_pool.example.id]
  probe_id = azurerm_lb_probe.web_lb_probe.id 
}

resource "azurerm_network_interface_backend_address_pool_association" "nic_lb_association" {
  for_each = var.vwg
  network_interface_id    = azurerm_network_interface.web_nic[each.key].id
  ip_configuration_name   = azurerm_network_interface.web_nic[each.key].ip_configuration[0].name
  backend_address_pool_id = azurerm_lb_backend_address_pool.example.id
}
