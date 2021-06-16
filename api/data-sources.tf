data "azurerm_function_app" "function" {
  name                = "azu-fn-${lower(var.environment_name_suffix)}-${lower(var.region_short_name)}-${replace(var.project_name, "-test", "")}-${var.resource_suffix}"
  resource_group_name = local.shared-rg
}

data "azurerm_function_app_host_keys" "function" {
  name                = "azu-fn-${lower(var.environment_name_suffix)}-${lower(var.region_short_name)}-${replace(var.project_name, "-test", "")}-${var.resource_suffix}"
  resource_group_name = local.shared-rg
}