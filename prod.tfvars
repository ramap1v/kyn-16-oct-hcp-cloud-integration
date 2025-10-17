#lets create a file prod.tfvars
#inside the file add this variables
resource_group_name="vinay-rg-kyn"
resource_group_location="eastus"
environment="prod"
business_unit = "IT"
vnet_name="kyn-prod-vnet"
vnet_address_space = ["11.0.0.0/16"]
web_subnet_name = "websubnet"
web_subnet_prefix = ["11.0.1.0/24"]


