data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "public" {
  location = var.location
  name     = "rg-aks-${var.prefix}"
}

locals {
  should_deploy_acr           = false
  should_deploy_log_analytics = false
  should_deploy_prometheus    = false
  should_deploy_grafana       = false
}

module "aks" {
  source                      = "./modules/aks"
  aks_name                    = "aks-${var.prefix}"
  default_node_pool_type      = "VirtualMachineScaleSets"
  default_node_pool_vm_size   = "Standard_D4s_v3"
  kubernetes_version          = var.kubernetes_version
  resource_group_location     = azurerm_resource_group.public.location
  resource_group_name         = azurerm_resource_group.public.name
  system_node_count           = 3
  should_deploy_log_analytics = local.should_deploy_log_analytics
  log_analytics_workspace_id  = local.should_deploy_log_analytics ? module.log_analytics[0].id : ""
}

module "acr" {
  count                     = local.should_deploy_acr ? 1 : 0
  source                    = "./modules/acr"
  acr_name                  = "acr${var.prefix}"
  aks_identity_principal_id = module.aks.principal_id
  location                  = azurerm_resource_group.public.location
  resource_group_name       = azurerm_resource_group.public.name
}

module "log_analytics" {
  count                             = local.should_deploy_log_analytics ? 1 : 0
  source                            = "./modules/log-analytics"
  log_analytics_location            = azurerm_resource_group.public.location
  log_analytics_resource_group_name = azurerm_resource_group.public.name
  log_analytics_sku                 = "PerGB2018"
  log_analytics_workspace_name      = "log-${var.prefix}"
}

module "prometheus" {
  count                   = local.should_deploy_prometheus ? 1 : 0
  source                  = "./modules/prometheus"
  aks_name                = module.aks.name
  aks_resource_group      = module.aks.resource_group_name
  prometheus_name         = "prometheus-${var.prefix}"
  resource_group_id       = azurerm_resource_group.public.id
  resource_group_location = azurerm_resource_group.public.location
}

module "managed_grafana" {
  count                   = (local.should_deploy_prometheus && local.should_deploy_grafana) ? 1 : 0
  source                  = "./modules/grafana"
  grafana_admin_object_id = data.azurerm_client_config.current.object_id
  grafana_name            = "amg-${var.prefix}"
  prometheus_id           = module.prometheus[0].id
  resource_group_location = azurerm_resource_group.public.location
  resource_group_name     = azurerm_resource_group.public.name
}
