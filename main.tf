data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "public" {
  location = var.location
  name     = "rg-aks-${var.prefix}"
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
}
