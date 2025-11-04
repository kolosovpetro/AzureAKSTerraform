variable "location" {
  type        = string
  description = "Resource group location where resources will be deployed."
  default     = "northeurope"
}

variable "prefix" {
  type        = string
  description = "Prefix used for naming all resources to ensure uniqueness."
  default     = "d01"
}

variable "kubernetes_version" {
  type        = string
  description = "Version of Kubernetes to be used in the AKS cluster."
  default     = "1.34.0"
}

variable "subscription_id" {
  type        = string
  description = "Azure Subscription ID where the resources will be deployed."
  default     = "1b08b9a2-ac6d-4b86-8a2f-8fef552c8371"
}

variable "tenant_id" {
  type        = string
  description = "Azure Tenant ID for authentication."
  default     = "b40a105f-0643-4922-8e60-10fc1abf9c4b"
}

variable "client_id" {
  type        = string
  description = "Azure Client ID (Service Principal) used for authentication."
  default     = "4d65956c-5661-494f-9e7e-c171aec0e53f"
}
