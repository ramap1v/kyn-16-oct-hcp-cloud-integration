resource "azurerm_resource_group" "kyn-rg" {                        #kyn-rg is the label
  name = "${local.resource_name_prefix}-${var.resource_group_name}" #s
  #sap-dev-gopal-rg-kyn
  location = var.resource_group_location
  tags     = local.project_tags
}



