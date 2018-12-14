provider "azurerm" {}


data "terraform_remote_state" "infra" {
    backend = "azurerm" 
    config {
    storage_account_name = "tfstatejshurak"
    container_name       = "tf-state-container"
    key                  = "ifra.state"
    access_key           = "5dxIUoX26sKdeKq7pXcZCS1YT+kwwA3GChQmDmGFtjx7XZiVE6I2L/0lVozLmmG3PyhkyoqPns31XIuAW2q4fw=="

    resource_group_name = "tf-state-rg"
  }
}

data "terraform_remote_state" "vnet" {
    backend = "azurerm" 
    config {
    storage_account_name = "tfstatejshurak"
    container_name       = "tf-state-container"
    key                  = "vnet.state"
    access_key           = "5dxIUoX26sKdeKq7pXcZCS1YT+kwwA3GChQmDmGFtjx7XZiVE6I2L/0lVozLmmG3PyhkyoqPns31XIuAW2q4fw=="

    resource_group_name = "tf-state-rg"
  }
}

data "terraform_remote_state" "storage" {
    backend = "azurerm" 
    config {
    storage_account_name = "tfstatejshurak"
    container_name       = "tf-state-container"
    key                  = "ifra/storage/storage.state"
    access_key           = "5dxIUoX26sKdeKq7pXcZCS1YT+kwwA3GChQmDmGFtjx7XZiVE6I2L/0lVozLmmG3PyhkyoqPns31XIuAW2q4fw=="

    resource_group_name = "tf-state-rg"
  }
}
resource "azurerm_network_interface" "main" {
    name                = "dc-nic"
    resource_group_name = "${data.terraform_remote_state.infra.resource_group_name}"
    location            = "${data.terraform_remote_state.infra.resource_group_location}"

    ip_configuration {
        name            = "backend_id_config"
        subnet_id       = "${data.terraform_remote_state.vnet.subnet_id}"
        private_ip_address_allocation   = "static"
        private_ip_address  = "10.0.3.10"      
    }

}


resource "azurerm_virtual_machine" "dc" {
    name            = "dc"
    location        = "${data.terraform_remote_state.infra.resource_group_location}"
    resource_group_name ="${data.terraform_remote_state.infra.resource_group_name}"
    vm_size             = "Standard_A1_v2"

    network_interface_ids = ["${azurerm_network_interface.main.id}"]
    delete_os_disk_on_termination = true
    #delete_data_disks_on_termination = true

    boot_diagnostics {
        enabled         = true
        storage_uri     = "${data.terraform_remote_state.storage.diagnostics_storage_uri}"
    }

    storage_image_reference {
        publisher       = "MicrosoftWindowsServer"
        offer           = "WindowsServer"
        sku             = "2019-Datacenter"
        version         = "latest"
    }

    storage_os_disk {
        name        = "os"
        caching     = "readwrite"
        create_option   = "fromimage"
        managed_disk_type   = "standard_lrs"
    }

    os_profile {
    computer_name  = "dc"
    admin_username = "testadmin"
    admin_password = "Password1234!"
  }
    os_profile_windows_config {
        provision_vm_agent = true
  }
}
