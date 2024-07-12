```hcl
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "aks_rg" {
  name     = "AKS-LLM-Cluster-01-RG"
  location = "EastUS"
}

resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = "AKS-LLM-Cluster-01"
  location            = "EastUS"
  resource_group_name = azurerm_resource_group.aks_rg.name
  dns_prefix          = "aksllmcluster01"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2s_v3"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "POC1"
  }
}
```