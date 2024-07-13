required_providers {
  azurerm = {
    source  = "hashicorp/azurerm"
    version = "3.91.0"
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "aks_rg" {
  name     = "AKS-CICD-RG"
  location = ""
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "AKS-CICD"
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name
  dns_prefix          = "akscicd"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = ""
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    environment = ""
  }
}