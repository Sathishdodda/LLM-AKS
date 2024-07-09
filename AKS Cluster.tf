
provider "azurerm" {
  features {}
  version = "~> 3.0"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group"
}

variable "location" {
  type        = string
  description = "The location of the resource group"
}

variable "aks_cluster_name" {
  type        = string
  description = "The name of the AKS cluster"
}

variable "dns_prefix" {
  type        = string
  description = "DNS prefix for the AKS cluster"
}

variable "agent_pool_profile" {
  type        = map(string)
  description = "Agent pool profile for the AKS cluster"
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_cluster_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = var.dns_prefix

  default_node_pool {
    name       = var.agent_pool_profile["name"]
    node_count = tonumber(var.agent_pool_profile["node_count"])
    vm_size    = var.agent_pool_profile["vm_size"]
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin = "azure"
    load_balancer_sku = "standard"
  }

  tags = {
    environment = "production"
  }
}


# This Terraform code is configured to create an Azure Kubernetes Service (AKS) cluster with dynamic inputs for the resource group name, AKS cluster name, location, DNS prefix, and agent pool profile. Ensure to provide appropriate values for these variables during your Terraform deployment.
