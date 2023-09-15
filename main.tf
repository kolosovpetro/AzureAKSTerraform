data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "public" {
  location = var.resource_group_location
  name     = local.resource_group_name
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = local.cluster_name
  kubernetes_version  = var.kubernetes_version
  location            = azurerm_resource_group.public.location
  resource_group_name = azurerm_resource_group.public.name
  dns_prefix          = local.cluster_name

  default_node_pool {
    name                = "systempool"
    node_count          = var.system_node_count
    vm_size             = "Standard_DS2_v2"
    type                = "VirtualMachineScaleSets"
    enable_auto_scaling = false
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    load_balancer_sku = "standard"
    network_plugin    = "kubenet" # CNI
  }
}

resource "azurerm_container_registry" "acr" {
  count               = var.should_deploy_acr ? 1 : 0
  name                = local.acr_name
  resource_group_name = azurerm_resource_group.public.name
  location            = azurerm_resource_group.public.location
  sku                 = "Standard"
  admin_enabled       = false
}

resource "azurerm_role_assignment" "role_acrpull" {
  count                            = var.should_deploy_acr ? 1 : 0
  scope                            = azurerm_container_registry.acr[0].id
  role_definition_name             = "AcrPull"
  principal_id                     = azurerm_kubernetes_cluster.aks.identity[0].principal_id
  skip_service_principal_aad_check = true
}
