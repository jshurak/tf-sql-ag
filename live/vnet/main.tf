provider "azurerm" {}

resource "azurerm_resource_group" "network-rg" {
    name    = "production-vnet"
    location    = "East US"
}

resource "azurerm_virtual_network" "network" {
    name    = "production-network"
    address_space   = ["10.0.0.0/16"]
    location        = "${azurerm_resource_group.network-rg.location}"
    resource_group_name = "${azurerm_resource_group.network-rg.name}"

}

resource "azurerm_subnet" "backend" {
    resource_group_name = "${azurerm_resource_group.network-rg.name}"
    virtual_network_name    = "${azurerm_virtual_network.network.name}"
    name            = "backend"
    address_prefix  = "10.0.3.0/24"
}