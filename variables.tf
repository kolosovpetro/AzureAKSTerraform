variable "location" {
  type        = string
  description = "Resource group location"
  default     = "northeurope"
}

variable "prefix" {
  type        = string
  description = "Prefix for all resources"
  default     = "d01"
}

variable "kubernetes_version" {
  type        = string
  description = "Kubernetes version"
  default     = "1.31.2"
}
