data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "public" {
  location = var.resource_group_location
  name     = local.resource_group_name
}

module "log_analytics" {
  source                            = "./modules/log_analytics"
  log_analytics_location            = azurerm_resource_group.public.location
  log_analytics_resource_group_name = azurerm_resource_group.public.name
  log_analytics_sku                 = "PerGB2018"
  log_analytics_workspace_name      = local.workspace_name
}

module "aks" {
  source                     = "./modules/aks"
  aks_name                   = local.aks_name
  default_node_pool_type     = var.default_node_pool_type
  default_node_pool_vm_size  = var.default_node_pool_vm_size
  kubernetes_version         = var.kubernetes_version
  log_analytics_workspace_id = module.log_analytics.id
  resource_group_location    = azurerm_resource_group.public.location
  resource_group_name        = azurerm_resource_group.public.name
  system_node_count          = var.system_node_count

  depends_on = [
    module.log_analytics
  ]
}

module "acr" {
  source                    = "./modules/acr"
  acr_name                  = local.acr_name
  aks_identity_principal_id = module.aks.principal_id
  resource_group_location   = azurerm_resource_group.public.location
  resource_group_name       = azurerm_resource_group.public.name

  depends_on = [
    module.aks
  ]
}

module "prometheus" {
  source                  = "./modules/prometheus"
  aks_name                = module.aks.name
  aks_resource_group      = module.aks.resource_group_name
  prometheus_name         = local.prometheus_name
  resource_group_id       = azurerm_resource_group.public.id
  resource_group_location = azurerm_resource_group.public.location

  depends_on = [
    module.aks
  ]
}

module "grafana" {
  source                  = "./modules/grafana"
  grafana_admin_object_id = data.azurerm_client_config.current.object_id
  grafana_name            = local.grafana_name
  prometheus_id           = module.prometheus.id
  resource_group_location = azurerm_resource_group.public.location
  resource_group_name     = azurerm_resource_group.public.name

  depends_on = [
    module.prometheus
  ]
}
