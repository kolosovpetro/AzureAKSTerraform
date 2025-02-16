# Azure Kubernetes Service (AKS) terraform module

Azure Kubernetes Service (AKS) terraform module.

## Required Azure providers

- Microsoft.Monitor
    - `az provider register --namespace Microsoft.Monitor`
    - `az provider show --namespace Microsoft.Monitor --query "registrationState"`
- Microsoft.Dashboard
    - `az provider register --namespace Microsoft.Dashboard`
    - `az provider show --namespace Microsoft.Dashboard --query "registrationState"`

## Terraform Modules implemented

- ACR -- creates new ACR and assigns `acrPull` role to AKS
- ACR association -- assigns AKS `acrPull` role to existing ACR
- AKS
- Log analytics
- Managed Prometheus
- Managed Grafana (requires `Microsoft.Dashboard`)

## Terraform providers used

- https://registry.terraform.io/providers/Azure/azapi/latest/docs

## K8s Architecture

![Kubernetes Architecture](./img/Kubernetes_architecture.png)

