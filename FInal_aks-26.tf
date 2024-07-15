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
  name     = "Final_aks_26_rg"
  location = "East US"
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "Final_aks-26"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "Finalaks26"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_DS2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    environment = "dev"
  }
}

output "aks_cluster_name" {
  value = azurerm_kubernetes_cluster.aks.name
}

output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}
