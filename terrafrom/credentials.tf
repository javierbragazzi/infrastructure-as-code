# Datos de autenticación de Azure
provider "azurerm" {
  features {}
  subscription_id = <<USER_SUSCRPITION>>
  client_id       = <<USER_ID>>
  client_secret   = <<USER_PASSWORD>>
  tenant_id       = <<USER_TENANT>>
}