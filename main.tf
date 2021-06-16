# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = ">= 2.26"
    }
  }
}

provider "azurerm" {
  features {}
}

terraform {
  backend "azurerm" {
    # variables are not allowed so file has to be transformed during CI/CD
    resource_group_name  = "RG-ANISRG-EU-ANISSHARED-001"
    storage_account_name = "staanisrgeuterraform001"
    container_name       = "terraform"
    key                  = "anisshared-dev-eu-main.terraform.tfstate"
  }
}

resource "azurerm_resource_group" "rg" {
  name     = local.shared-rg
  location = var.region_name
  
  tags = {
	Environment = "Terraform Getting Started Anis"
    Team = "DevOps"
  }
}

resource "azurerm_api_management" "platform" {
  name                = upper(local.apim_name)
  resource_group_name = local.shared-rg
  location            = var.region_name
  publisher_name      = var.gateway_publisher_name
  publisher_email     = var.gateway_publisher_email

  sku_name = var.gateway_sku_name

  identity {
    type = "SystemAssigned"
  }

  protocols {
    enable_http2 = false
  }

  lifecycle {
    prevent_destroy = true
    ignore_changes  = all
  }
}

resource "azurerm_storage_account" "sta" {
  name                     = local.storage_account_name
  resource_group_name      = local.shared-rg
  location                 = var.region_name
  account_replication_type = "RAGRS"
  account_tier             = "Standard"
  account_kind             = "StorageV2"
  min_tls_version          = "TLS1_2"
  allow_blob_public_access = true

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_app_service_plan" "pftrans" {
  name                = "asp-rg${lower(var.environment_name_suffix)}-${lower(var.region_short_name)}-${replace(lower(var.project_name), "-test", "")}${var.resource_suffix}"
  resource_group_name = local.shared-rg
  location            = var.region_name
  kind                = "functionapp"
  sku {
    tier = "Dynamic"
    size = "Y1"
  }

  lifecycle {
    ignore_changes = [
      tags,
      name
    ]
  }
}

resource "azurerm_function_app" "pftrans" {
  name                       = "azu-fn-${lower(var.environment_name_suffix)}-${lower(var.region_short_name)}-${replace(var.project_name, "-test", "")}-${var.resource_suffix}"
  resource_group_name        = local.shared-rg
  location                   = var.region_name
  app_service_plan_id        = azurerm_app_service_plan.pftrans.id
  storage_account_name       = azurerm_storage_account.sta.name
  storage_account_access_key = azurerm_storage_account.sta.primary_access_key
  https_only                 = "false"
  version                    = "~3"
  enable_builtin_logging     = false

  identity {
    type = "SystemAssigned"
  }

  auth_settings {
    enabled                       = false
    token_refresh_extension_hours = 0
  }

  site_config {
    http2_enabled   = false
    min_tls_version = "1.2"
    cors {
      allowed_origins = [
        "https://functions-next.azure.com",
        "https://functions-staging.azure.com",
        "https://functions.azure.com",
      ]
    }
  }

  lifecycle {
    ignore_changes = [
      tags,
      app_settings
    ]
  }
}