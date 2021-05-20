provider "azurerm" {
  version         = 2.0
    features {}

}
#resource "azurerm_resource_group" "example" {
 # name     = "example-resources"
  #location = "West Europe"
#}

resource "azurerm_virtual_network" "vnetexample" {
  name                = "testvnet"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.resourceGroupName
}

resource "azurerm_subnet" "subexample" {
  name                 = "AzureFirewallSubnet"
   resource_group_name = var.resourceGroupName
  virtual_network_name = azurerm_virtual_network.vnetexample.name
  address_prefix     = "10.0.1.0/24"
}

resource "azurerm_public_ip" "azurepip" {
  name                = "testpip"
  location            = var.location
  resource_group_name = var.resourceGroupName
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_firewall" "example" {
  name                = "testfirewall"
  location            = var.location
  resource_group_name = var.resourceGroupName

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.subexample.id
    public_ip_address_id = azurerm_public_ip.azurepip.id
  }
}
