resource "azurerm_api_management_api_operation_policy" "get-users-userId" {
  count               = 1
  resource_group_name = local.shared-rg 
  api_management_name = local.apim_name
  api_name            = azurerm_api_management_api.test-api.name
  operation_id        = "get-users-userId"
  xml_content = templatefile("api-management/policies/api-operation-basic-auth-policy.xml", {
    Basic-Auth-UserName = var.basic_auth_username
    Backend-Id          = "test-api"
  })
}

resource "azurerm_api_management_api_operation_policy" "get-users-email" {
  count               = 1
  resource_group_name = local.shared-rg 
  api_management_name = local.apim_name
  api_name            = azurerm_api_management_api.test-api.name
  operation_id        = "get-users-email"
  xml_content = templatefile("api-management/policies/api-operation-basic-auth-policy.xml", {
    Basic-Auth-UserName = var.basic_auth_username
    Backend-Id          = "test-api"
  })
}