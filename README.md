# Azure Kubernetes Service (AKS) terraform module

Azure Kubernetes Service (AKS) terraform module.

## Modules implemented

- ACR -- creates new ACR and assigns `acrPull` role to AKS
- ACR association -- assigns AKS `acrPull` role to existing ACR
- AKS
- Log analytics
- Managed Prometheus
- Managed Grafana (requires `Microsoft.Dashboard`)

## K8s Architecture

![Kubernetes Architecture](./img/Kubernetes_architecture.png)

## Providers used

- https://registry.terraform.io/providers/Azure/azapi/latest/docs

## Notes

Register grafana provider before terraform apply:

- `az provider register --namespace Microsoft.Dashboard`
- `az provider show --namespace Microsoft.Dashboard --query "registrationState"`

