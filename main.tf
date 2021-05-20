provider "azurerm" {
  version         = 2.0
  subscription_id = var.subscriptionID
      features {}
}

resource "azurerm_resource_group" "rg" {
  name     = var.resourceGroupName
  location = var.location
}

resource "azurerm_public_ip" "example1" {
  name                = "PublicIPForLB"
  location            = var.location
  resource_group_name = var.resourceGroupName
  allocation_method   = "Static"
}

resource "azurerm_lb" "example2" {
  name                = "TestLoadBalancer"
  location            = "West US"
  resource_group_name = var.resourceGroupName
    frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.example1.id
  }
}