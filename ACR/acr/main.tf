
resource "random_integer" "ri" {
    min = 10000
    max = 99999
}

# create azure container registry #
resource "azurerm_container_registry" "acr" {
  name                = "azacr${random_integer.ri.result}"
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  sku                 = "Premium"
  admin_enabled       = false
}