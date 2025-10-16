resource "null_resource" "copy_ssh_key" {
  #this null resource will execute on jump vm
  #it should not execute this block till my jump vm is ready
  depends_on = [ azurerm_linux_virtual_machine.jump_vm ]
  connection {
    type = "ssh" #rdp
    host = azurerm_linux_virtual_machine.jump_vm.public_ip_address
    user = azurerm_linux_virtual_machine.jump_vm.admin_username
    private_key = file("${path.module}/ssh-keys/terraform-azure.pem")
  }
  #once we made the connection we need to upload a file 
  provisioner "file" {
    source = "ssh-keys/terraform-azure.pem" 
    destination = "/tmp/terraform-azure.pem"
  }
  provisioner "remote-exec" {
    inline = [ 
      "sudo chmod 400 /tmp/terraform-azure.pem"
     ]
  }
}