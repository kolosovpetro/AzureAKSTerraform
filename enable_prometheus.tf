resource "null_resource" "enable_azure_monitor_metrics" {
  provisioner "local-exec" {
    interpreter = ["PowerShell", "-Command"]
    command     = <<-EOT

      az aks update --enable-azure-monitor-metrics `
                    -g ${azurerm_kubernetes_cluster.aks.resource_group_name} `
                    -n ${azurerm_kubernetes_cluster.aks.name} `
                    --azure-monitor-workspace-resource-id ${azapi_resource.prometheus.id}
    EOT
  }

  depends_on = [
    azurerm_kubernetes_cluster.aks,
    azapi_resource.prometheus
  ]

  # for linux
  # provisioner "local-exec" {
  #   command    = "az aks update --enable-azuremonitormetrics -g ${azurerm_kubernetes_cluster.aks.resource_group_name} -n ${azurerm_kubernetes_cluster.aks.name} --azure-monitor-workspace-resource-id ${azapi_resource.prometheus.id}"
  # }
}
