provider "azurerm" {}

resource "azurerm_resource_group" "state-rg" {
    name            = "tf-state-rg"
    location            = "east us"
}

resource "azurerm_storage_account" "state" {
    name            = "tfstatejshurak"
    resource_group_name = "${azurerm_resource_group.state-rg.name}"
    location            = "${azurerm_resource_group.state-rg.location}"
    account_tier        = "standard"
    account_replication_type = "LRS"

    tags {
        environment = "tf-configuration"
    }
}

resource "azurerm_storage_container" "state-ct" {
    name                = "tf-state-container"
    resource_group_name = "${azurerm_resource_group.state-rg.name}"
    storage_account_name    = "${azurerm_storage_account.state.name}"
}


