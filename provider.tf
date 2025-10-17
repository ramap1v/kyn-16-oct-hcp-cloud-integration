#we need to provide the provider using terraform we are going to create resource in azure
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
  #we will put this information as remote backend
  backend "azurerm" {
    resource_group_name   = "vinay-storage-account" #replace it with the rg of storage account
    storage_account_name  = "vinaystorageaccountblob" #replace it with storage account name
    container_name        = "tfstate" #replace it with container name
    key                   = "project-1-eastus-terraform.tfstate" #this is the state file name
  }  
}
#this terraform block is going to download your plugin for cloud service provider

# Configure the Microsoft Azure Provider
provider "azurerm" {
  # resource_provider_registrations = "none" # This is only required when the User, Service Principal, or Identity running Terraform lacks the permissions to register Azure Resource Providers.

  features {}
 
}

