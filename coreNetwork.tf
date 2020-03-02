provider "azurerm" {
  version = "~> 1.33.1"
}

resource "azurerm_resource_group" "core" {
  name = "core"
  location = var.loc
  tags = var.tags
}

resource "azurerm_public_ip" "vpnGatewayPublicIp" {
  name = vpnGatewayPublicIp
  location = azurerm_resource_group.core.location
  resource_group_name = azurerm_resource_group.core.name
  allocation_method = "Dynamic"
  tags = azurerm_resource_group.core.tags
}
resource "azurerm_virtual_network" "VNET1" {
  name                = "core"
  location            = azurerm_resource_group.core.location
  resource_group_name = azurerm_resource_group.core.name
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["1.1.1.1", "1.0.0.1"]

  subnet {
    name           = "training"
    address_prefix = "10.0.1.0/24"
  }

  subnet {
    name           = "dev"
    address_prefix = "10.0.2.0/24"
  }

  subnet {
    name           = "GatewaySubnet"
    address_prefix = "10.0.0.0/24"
  }

  tags = azurerm_resource_group.core.tags
}
