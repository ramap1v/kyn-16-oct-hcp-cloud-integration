output "lb_public_ip_address" {
  description = "this is the public ip of the lb"
  value =  azurerm_public_ip.lb_publicip.ip_address
}
