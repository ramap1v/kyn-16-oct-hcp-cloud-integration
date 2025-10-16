
variable "vnet_name" {
  description = "value"
  type        = string
  default     = "kyn-vnet"
}

variable "vnet_address_space" {
  description = "this is the vnet address space"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "web_subnet_name" {
  description = "this is the web subnet name"
  type        = string
  default     = "web-subnet"
}

variable "web_subnet_prefix" {
  description = "this is the web subnet prefix"
  type        = list(string)
  default     = ["10.0.1.0/24"]

}