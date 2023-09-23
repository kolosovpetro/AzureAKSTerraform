resource "azapi_resource" "prometheus" {
  type      = "microsoft.monitor/accounts@2021-06-03-preview"
  name      = local.prometheus_name
  parent_id = azurerm_resource_group.public.id
  location  = azurerm_resource_group.public.name
}
