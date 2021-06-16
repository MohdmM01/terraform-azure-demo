resource "azurerm_api_management_named_value" "basic-auth-password" {
  name                = "basic-auth-password"
  resource_group_name = local.shared-rg 
  api_management_name = local.apim_name
  display_name        = "basic-auth-password"
  value               = var.basic_auth_password
  secret              = true
}

resource "azurerm_api_management_named_value" "test-named-value" {
  name                = "test-named-value"
  resource_group_name = local.shared-rg 
  api_management_name = local.apim_name
  display_name        = "test-named-value"
  value               = "test-named-value-value"
  secret              = false
}