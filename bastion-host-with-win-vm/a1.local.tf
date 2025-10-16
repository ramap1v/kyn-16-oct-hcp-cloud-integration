locals {
  owner                = var.business_unit #sap
  environment          = var.environment   #dev
  resource_name_prefix = "${var.business_unit}-${var.environment}"
  project_tags = {                  #project tag is a name custom value
    Owner       = local.owner       #we are defining expression in key value format sap
    Environment = local.environment #dev
    Project     = "KYN"             #custom value
  }
}