output "vnet_name" {
    value   = "${azurerm_virtual_network.network.name}"
}

output "subnet_id" {
    value   = "${azurerm_subnet.backend.id}"
}