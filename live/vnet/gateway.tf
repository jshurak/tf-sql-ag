resource "azurerm_subnet" "gateway" {
    resource_group_name     = "${azurerm_resource_group.network-rg.name}"
    
    virtual_network_name    = "${azurerm_virtual_network.network.name}"
    name                    = "GatewaySubnet"
    address_prefix          = "10.0.2.0/24"

} 

resource "azurerm_public_ip" "gateway" {
    resource_group_name     = "${azurerm_resource_group.network-rg.name}"
    location                = "${azurerm_resource_group.network-rg.location}"
    name                    = "gateway-pip"
    
    public_ip_address_allocation    = "Dynamic"
}

resource "azurerm_virtual_network_gateway" "gateway" {
    name                = "vpnGateway"
    resource_group_name = "${azurerm_resource_group.network-rg.name}"
    location            = "${azurerm_resource_group.network-rg.location}"

    type                = "vpn"
    sku                 = "basic"

    ip_configuration {
        subnet_id       = "${azurerm_subnet.gateway.id}"
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id = "${azurerm_public_ip.gateway.id}"
    }

    vpn_client_configuration {
        address_space = ["192.168.1.0/24"]
    }
}