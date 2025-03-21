terraform {
  required_version = ">= 1.3.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.45"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.1"
    }
  }
}

provider "azurerm" {
  partner_id = "31912fbf-f6dd-5176-bffb-0a01e8ac71f2"
  features {}
}
