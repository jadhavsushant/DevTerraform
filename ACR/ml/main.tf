
terraform {
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "3.1.1"
    }
    azapi = {
      source  = "Azure/azapi"
      version = "0.4.0"
    }
  }
}

# storage account and thred protection
resource "azurerm_storage_account" "example" {
  name                     = "${var.storage_account_name}${var.resource_name_suffix}"
  resource_group_name      = var.resource_group_name
  location                 = var.resource_group_location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  identity {
    type = "SystemAssigned"
  }

  tags = {
    environment = "staging"
  }
}

resource "azurerm_advanced_threat_protection" "ana_stg_account_thred_protection" {
  target_resource_id = azurerm_storage_account.example.id
  enabled            = true

}


# create app insight
resource "azurerm_application_insights" "stg_app_insight" {
  name                = "${var.app_insight_name}-${var.resource_name_suffix}"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  application_type    = "web"

}

# define the ml resource workspace
resource "azurerm_machine_learning_workspace" "ml_workspace" {
  name                    = "${var.azure_ml_workspace_name}-${var.resource_name_suffix}"
  location                = var.resource_group_location
  resource_group_name     = var.resource_group_name
  application_insights_id = azurerm_application_insights.stg_app_insight.id
  storage_account_id      = azurerm_storage_account.example.id
  sku_name                = "Basic"
  key_vault_id            = var.keyvault_id

  identity {
    type = "SystemAssigned"
  }

  lifecycle {
    ignore_changes = [
      container_registry_id,
    ]
    
  }

  depends_on = [
    azurerm_storage_account.example,
    azurerm_application_insights.stg_app_insight
  ]
  # attach ml acr to ml workspace

}

resource "azapi_update_resource" "attach_acr_to_ml_ws" {
  resource_id = azurerm_machine_learning_workspace.ml_workspace.id
  type        = "Microsoft.MachineLearningServices/workspaces@2022-05-01"
  body = jsonencode({
    properties = {
      containerRegistry : "${var.azure_container_registry_id}"
    }
  })
}
