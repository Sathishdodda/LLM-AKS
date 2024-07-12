terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.91.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "aks_rg"
  location = "eastus"
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "Aks_latest"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "akslatestdns"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2s_v4"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    environment = ""
  }
}