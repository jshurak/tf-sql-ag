output "state-storage-account-name" {
    value   = "${azurerm_storage_account.state.name}"
}

output "state-container-name" {
    value   = "${azurerm_storage_container.state-ct.name}"
}

output "diagnostics_storage_account_name" {
    value   = "${azurerm_storage_account.diagnostics.name}"
}

output "diagnostics_storage_uri" {
    value   = "https://${azurerm_storage_account.diagnostics.name}.blob.core.windows.net"
}