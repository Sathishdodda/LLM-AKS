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
  name     = "rg-aks-final-10"
  location = "eastus"
  tags = {
    environment = "development"
  }
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aks-final-10"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "aksfinal10dns"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2s_v4"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    environment = "development"
  }
}

output "aks_cluster_name" {
  value = azurerm_kubernetes_cluster.aks.name
}

output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}