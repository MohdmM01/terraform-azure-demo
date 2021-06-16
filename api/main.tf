provider "azurerm" {
  skip_provider_registration = true
  features {

  }
}

terraform {
  backend "azurerm" {
    # variables are not allowed so file has to be transformed during CI/CD
    resource_group_name  = "RG-ANISRG-EU-ANISSHARED-001"
    storage_account_name = "staanisrgeuterraform001"
    container_name       = "terraform"
    key                  = "anisshared-dev-eu-api.terraform.tfstate"
  }
}
