terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.100"
    }
  }

  # Uncomment to use Azure Blob as remote backend
  # backend "azurerm" {
  #   resource_group_name  = "rg-tfstate"
  #   storage_account_name = "stterraformstate"
  #   container_name       = "tfstate"
  #   key                  = "demo.terraform.tfstate"
  # }
}

provider "azurerm" {
  features {}

  subscription_id = var.subscription_id
}
