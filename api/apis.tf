resource "azurerm_api_management_api" "test-api" {
  name                = "test-api"
  resource_group_name = local.shared-rg 
  api_management_name = local.apim_name
  display_name        = "test"
  description         = "TEST API"
  revision            = var.revision
  path                = "test"
  protocols           = [var.protocol]
  service_url           = "https://azu-fn-${lower(var.environment_name)}-${lower(var.region_short_name)}-anisshared-${var.resource_suffix}.azurewebsites.net/api"

  subscription_required = true
  subscription_key_parameter_names {
    header = "Ocp-Apim-Subscription-Key"
    query  = "subscription-Key"
  }

  import {
    content_format = "openapi"
    content_value  = file(abspath("api-management/apis/test-api.yaml"))
  }
}