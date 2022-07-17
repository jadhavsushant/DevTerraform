data "azurerm_client_config" "current" {
}

module "kv" {
    source = "./kv"
    resource_group_location = var.rg_location
    resource_group_name = var.rg_name
}

module "acr" {
    source = "./acr"
    resource_group_location = var.rg_location
    resource_group_name = var.rg_name
}

module "ml" {
    source = "./ml"
    resource_name_suffix = var.resource_name_suffix
    resource_group_location = var.rg_location
    resource_group_name = var.rg_name
    storage_account_name = var.storage_account_name
    keyvault_id = module.kv.keyvault_id
    azure_container_registry_id = module.acr.azure_acr_id
}
