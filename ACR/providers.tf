terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "3.3.2"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.1.0"
    }
  }
}

provider "azurerm" {
  features {
     key_vault {
      purge_soft_delete_on_destroy = true
    }
  }
  # Configuration options
}

provider "random" {
  # Configuration options
}
