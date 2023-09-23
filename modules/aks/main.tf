resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_name
  kubernetes_version  = var.kubernetes_version
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.aks_name

  default_node_pool {
    name                = "systempool"
    node_count          = var.system_node_count
    vm_size             = var.default_node_pool_vm_size
    type                = var.default_node_pool_type
    enable_auto_scaling = false
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    load_balancer_sku = "standard"
    network_plugin    = "kubenet" # CNI
  }

  oms_agent {
    log_analytics_workspace_id      = var.log_analytics_workspace_id
    msi_auth_for_monitoring_enabled = true
  }

  lifecycle {
    ignore_changes = [
      monitor_metrics
    ]
  }
}
