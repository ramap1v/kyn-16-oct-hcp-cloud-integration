variable "resource_group_name" {
  description = "this is the name of the resource group"
  type        = string #map of string boolean number list
  default     = "vinay-rg-kyn"
}

variable "resource_group_location" {
  description = "this is the location of the resource group"
  type        = string #map of string boolean number list
  default     = "eastus"

}

variable "environment" {
  type        = string
  description = "this is the environment"
  default     = "dev"
}

variable "business_unit" {
  type        = string
  description = "this is the business unit"
  default     = "sap"
}
