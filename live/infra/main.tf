resource "azurerm_resource_group" "infra-rg" {
    name        = "infrastructure-rg"
    location    = "East US"
}

output "resource_group_name" {
    value = "${azurerm_resource_group.infra-rg.name}"
}

output "resource_group_location" {
    value   = "${azurerm_resource_group.infra-rg.location}"
}