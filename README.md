# Azure Kubernetes Service (AKS) terraform module

Azure Kubernetes Service (AKS) terraform module

## K8s Architecture

![Kubernetes Architecture](./img/Kubernetes_architecture.png)

### Definitions

- **Cluster**: A set of nodes that run containerized applications managed by Kubernetes, consisting of a control plane that orchestrates the cluster and worker nodes that run the applications.

- **Control Plane**: A part of a Cluster that consists of API Server, Controller Manager, Scheduler, and Etcd. Responsible for all interactions with Kubernetes nodes, cluster state, and interactions with developers.

- **API Server**: A component of the Control Plane that receives `kubectl` commands from developers to update the Cluster state.

- **Controller Manager**: A component of the Control Plane that interacts with the cloud provider to manage cloud resources, such as disks.

- **Scheduler**: A component of the Control Plane responsible for assigning newly created pods to specific nodes in the Cluster.

- **Etcd**: A component of the Control Plane that keeps cluster configuration (state) in key-value format.

- **Node**: A virtual or physical machine managed by the Control Plane inside the Cluster, consisting of Kubelet, Kubeproxy, Container Runtime, and Pods.

- **Kubelet**: A component of the Node responsible for communication between the Control Plane API Server and the Node. It executes commands from the API Server, maintaining the proper Pod state.

- **Kubeproxy**: A component of the Node that ensures that pods are publicly available to the external network and accessible to users.

- **Container Runtime**: A software component of the Node that manages the execution and lifecycle of containerized applications. It handles tasks such as starting, stopping, and managing containers, as well as ensuring their proper isolation and resource allocation.

- **Pod**: A component of the Node that represents the smallest deployable unit, handling one or more instances of containerized applications.

- **Deployment**: A resource object that defines the desired state of a containerized application, such as the number of replicas of a pod, the container images to use, and update strategies.

- **Service**: An abstraction that defines a logical set of pods and a policy to access them. Services enable communication between different parts of an application and can expose an application to the outside world.

- **Cluster IP**: A type of Service that provides an internal IP address within the Kubernetes cluster. This IP address is accessible only from within the cluster, allowing different services and pods to communicate with each other without exposing them to the outside world.

- **NodePort**: A type of Service that exposes an application by assigning a static port on each Node's public IP address. This allows internet traffic to access the service by sending requests to the Node's public IP address on the specified port.

- **LoadBalancer**: A type of Service that automatically provisions an external load balancer to distribute incoming traffic across the pods of a service. It provides a single external IP address, allowing external clients to access the service, and ensures that traffic is balanced across the available pods for better performance and reliability.

- **ConfigMap**: A resource that allows you to store configuration data in key-value pairs. It decouples configuration details from application code, enabling you to manage application settings separately and update them without rebuilding your application images.

- **Secret**: A resource object used to store sensitive information such as passwords, tokens, and keys. It helps manage and protect sensitive data by keeping it separate from the application code.

- **Persistent Volume**: A storage resource provisioned in a cluster that provides a way for users to manage durable storage separately from the lifecycle of individual pods.

- **Ingress Controller**: A specialized load balancer that manages external access to services within a cluster, typically via HTTP and HTTPS. It implements the rules defined in Ingress resources to route and control traffic, enabling features like host-based and path-based routing, SSL termination, and load balancing for multiple services.

- **Horizontal Pod Autoscaler (HPA)**: Automatically adjusts the number of pod replicas in a deployment or replica set based on observed CPU utilization or other custom metrics.

- **Cluster Autoscaler**: Automatically adjusts the number of nodes in a cluster based on the resource demands of the pods.


## Pre-commit configuration

- Install python3 via windows store
- `pip install --upgrade pip`
- `pip install pre-commit`
- Update PATH variable
- `pre-commit install`

## Install terraform docs

- `choco install terraform-docs`

## Install tflint

- `choco install tflint`

## Documentation

- https://github.com/antonbabenko/pre-commit-terraform
- https://github.com/kolosovpetro/AzureTerraformBackend
- https://github.com/terraform-docs/terraform-docs
- https://terraform-docs.io/user-guide/installation/
- https://pre-commit.com/

## Storage account configuration file

```bash
storage_account_name = "storage_account_name"
container_name       = "container_name"
key                  = "terraform.tfstate"
sas_token            = "sas_token"
```

## Deploy storage account for terraform state

- See [CreateAzureStorageAccount.ps1](./CreateAzureStorageAccount.ps1)

# Module documentation

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azapi"></a> [azapi](#requirement\_azapi) | =1.9.0 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | =2.43.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | =3.71.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.71.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_acr"></a> [acr](#module\_acr) | ./modules/acr | n/a |
| <a name="module_aks"></a> [aks](#module\_aks) | ./modules/aks | n/a |
| <a name="module_grafana"></a> [grafana](#module\_grafana) | ./modules/grafana | n/a |
| <a name="module_log_analytics"></a> [log\_analytics](#module\_log\_analytics) | ./modules/log_analytics | n/a |
| <a name="module_prometheus"></a> [prometheus](#module\_prometheus) | ./modules/prometheus | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group.public](https://registry.terraform.io/providers/hashicorp/azurerm/3.71.0/docs/resources/resource_group) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/3.71.0/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acr_name"></a> [acr\_name](#input\_acr\_name) | Name of the ACR | `string` | n/a | yes |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of the AKS cluster | `string` | n/a | yes |
| <a name="input_default_node_pool_type"></a> [default\_node\_pool\_type](#input\_default\_node\_pool\_type) | Default node pool type | `string` | n/a | yes |
| <a name="input_default_node_pool_vm_size"></a> [default\_node\_pool\_vm\_size](#input\_default\_node\_pool\_vm\_size) | Default node pool VM size | `string` | n/a | yes |
| <a name="input_kubernetes_version"></a> [kubernetes\_version](#input\_kubernetes\_version) | Kubernetes version | `string` | n/a | yes |
| <a name="input_log_analytics_sku"></a> [log\_analytics\_sku](#input\_log\_analytics\_sku) | Log analytics SKU | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Prefix for all resources | `string` | n/a | yes |
| <a name="input_resource_group_location"></a> [resource\_group\_location](#input\_resource\_group\_location) | Resource group location | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Resource group name | `string` | n/a | yes |
| <a name="input_should_deploy_acr"></a> [should\_deploy\_acr](#input\_should\_deploy\_acr) | Should deploy ACR | `bool` | n/a | yes |
| <a name="input_should_deploy_log_analytics"></a> [should\_deploy\_log\_analytics](#input\_should\_deploy\_log\_analytics) | Should deploy log analytics | `bool` | n/a | yes |
| <a name="input_should_deploy_prometheus"></a> [should\_deploy\_prometheus](#input\_should\_deploy\_prometheus) | Should deploy prometheus | `bool` | n/a | yes |
| <a name="input_system_node_count"></a> [system\_node\_count](#input\_system\_node\_count) | Number of system nodes | `number` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aks_name"></a> [aks\_name](#output\_aks\_name) | n/a |
| <a name="output_grafana_endpoint"></a> [grafana\_endpoint](#output\_grafana\_endpoint) | n/a |
| <a name="output_rg_name"></a> [rg\_name](#output\_rg\_name) | n/a |
| <a name="output_subscription"></a> [subscription](#output\_subscription) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
