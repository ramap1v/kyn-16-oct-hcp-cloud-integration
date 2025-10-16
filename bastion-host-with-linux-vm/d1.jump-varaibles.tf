variable "jump_subnet_name" {
  description = "this is the jump subnet name"
  type        = string
  default     = "jump-subnet"
}

variable "jump_subnet_prefix" {
  description = "this is the jump subnet prefix"
  type        = list(string)
  default     = ["10.0.2.0/24"]

}