variable "vwg" {
  description = "character in start war"
  type = map(string)
  default = {
    audi = "Standard_F2", #2 core with 4 Gb
    bentley = "Standard_D2s_v3" #2 core with 8 GB
    
  }
}