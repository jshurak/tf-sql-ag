resource "azurerm_resource_group" "diagnostics-rg" {
    name            = "vm-diagnostics-rg"
    location            = "east us"
}

resource "azurerm_storage_account" "diagnostics" {
    name            = "vmdiagjshurak"
    resource_group_name = "${azurerm_resource_group.diagnostics-rg.name}"
    location            = "${azurerm_resource_group.diagnostics-rg.location}"
    account_tier        = "standard"
    account_replication_type = "LRS"

    tags {
        environment = "prod"
    }
}



