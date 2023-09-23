output "rg_name" {
  value = azurerm_resource_group.public.name
}

output "aks_name" {
  value = module.aks.name
}

output "subscription" {
  value = data.azurerm_client_config.current.subscription_id
}

output "grafana_endpoint" {
  value = module.grafana.grafana_endpoint
}
