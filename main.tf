data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "public" {
  location = var.location
  name     = "rg-aks-${var.prefix}"
}

locals {
  should_deploy_log_acr       = true
  should_deploy_log_analytics = true
  should_deploy_prometheus    = true
  should_deploy_grafana       = true
}

module "aks" {
  source                      = "./modules/aks"
  aks_name                    = "aks-${var.prefix}"
  default_node_pool_type      = "VirtualMachineScaleSets"
  default_node_pool_vm_size   = "Standard_DS2_v2"
  kubernetes_version          = var.kubernetes_version
  resource_group_location     = azurerm_resource_group.public.location
  resource_group_name         = azurerm_resource_group.public.name
  system_node_count           = 3
  should_deploy_log_analytics = local.should_deploy_log_analytics
  log_analytics_workspace_id  = module.log_analytics.id
}

module "acr" {
  source                    = "./modules/acr"
  acr_name                  = "acr${var.prefix}"
  aks_identity_principal_id = module.aks.principal_id
  location                  = azurerm_resource_group.public.location
  resource_group_name       = azurerm_resource_group.public.name
}

module "log_analytics" {
  source                            = "./modules/log-analytics"
  log_analytics_location            = azurerm_resource_group.public.location
  log_analytics_resource_group_name = azurerm_resource_group.public.name
  log_analytics_sku                 = "PerGB2018"
  log_analytics_workspace_name      = "log-${var.prefix}"
}

module "prometheus" {
  source                  = "./modules/prometheus"
  aks_name                = module.aks.name
  aks_resource_group      = module.aks.resource_group_name
  prometheus_name         = "prometheus-${var.prefix}"
  resource_group_id       = azurerm_resource_group.public.id
  resource_group_location = azurerm_resource_group.public.location
}

module "managed_grafana" {
  source                  = "./modules/grafana"
  grafana_admin_object_id = data.azurerm_client_config.current.object_id
  grafana_name            = "amg-${var.prefix}"
  prometheus_id           = module.prometheus.id
  resource_group_location = azurerm_resource_group.public.location
  resource_group_name     = azurerm_resource_group.public.name
}
