terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.10.0"
    }
  }

  required_version = ">= 1.1.0"
}

# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "kubernetes-rg"
  location = var.location

  tags = var.tags_all_resources
}