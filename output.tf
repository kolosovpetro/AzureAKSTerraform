output "rg_name" {
  value = azurerm_resource_group.public.name
}

output "aks_name" {
  value = module.aks.name
}

output "subscription" {
  value = data.azurerm_client_config.current.subscription_id
}

output "connect_command" {
  value = "az aks get-credentials --resource-group ${azurerm_resource_group.public.name} --name ${module.aks.name} --subscription ${data.azurerm_client_config.current.subscription_id}"
}

output "grafana_endpoint" {
  value = length(module.managed_grafana) > 0 ? module.managed_grafana[0].grafana_endpoint : null
}

output "node_pool_list_command" {
  value = "az aks nodepool list --resource-group ${azurerm_resource_group.public.name} --cluster-name ${module.aks.name}"
}
