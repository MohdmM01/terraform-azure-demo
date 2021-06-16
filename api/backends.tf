resource "azurerm_api_management_backend" "function" {
  name                = "test-api"
  description         = "test-api"
  resource_group_name = local.shared-rg
  api_management_name = local.apim_name
  protocol            = "http"
  resource_id         = "https://management.azure.com${data.azurerm_function_app.function.id}"
  url                 = "https://${data.azurerm_function_app_host_keys.function.name}.azurewebsites.net/api"

  credentials {
    header = {
      x-functions-key = data.azurerm_function_app_host_keys.function.default_function_key
    }
  }

  tls {
    validate_certificate_chain = false
    validate_certificate_name  = false
  }
}