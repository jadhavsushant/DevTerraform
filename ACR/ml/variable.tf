variable "resource_name_suffix" {
  type = string
}

variable "resource_group_location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "storage_account_name" {
    type = string
}

variable "keyvault_id" {
    type = string
}

# app_insight

variable "app_insight_name" {
  type    = string
  default = "azdemoapp"
}

# ML

variable "azure_ml_workspace_name" {
  default = "azml-demo-ws"
}

variable "azure_container_registry_id" {
  type = string
}