resource "azurerm_resource_group" "infra-rg" {
    name        = "infrastructure-rg"
    location    = "East US"
}

output "resource-group-name" {
    value = "${azurerm_resource_group.infra-rg.id}"
}