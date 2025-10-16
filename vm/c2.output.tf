output "public_ip_address_vm" {
  description = "this is the public ip of the vm"
  value = azurerm_linux_virtual_machine.web_vm.public_ip_address
}

