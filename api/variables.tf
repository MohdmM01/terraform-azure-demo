variable "resource_suffix" {
  default     = "001"
  description = "this is in the gateway layer "
}

# Resource Management

variable "region_name" {
  default     = "West Europe"
  description = "The location in which to deploy the resource."
}

variable "region_short_name" {
  default     = "eu"
  description = "The location in which to deploy the resource."
}

# Release Information
variable "environment_name" {
  default     = "dev"
  description = "The three-letter environment_name name e.g. dev, test."
}

variable "environment_name_suffix" {
  default     = "dev"
  description = "The three-letter environment_name name e.g. dev, test."
}

variable "environment_name_suffix_short" {
  default     = "dev"
  description = "environment name with suffix without hiphens."
}

variable "project_name" {
  default     = "anisshared"
  description = "The name of the project."
}

variable "terraform_rg_suffix" {
  default     = "anisrg"
  description = "shared rg"
}

variable "gateway_sku_name" {
  default     = "Developer_1"
  description = "Api Management SKU"
}

variable "gateway_publisher_name" {
  default     = "Mohd Anis"
  description = "Api Management publisher name"
}

variable "gateway_publisher_email" {
  default     = "mohdanis.mohdmokhtar@mattheyasia.com"
  description = "Api Management publisher email"
}

variable "revision" {
  default     = "1"
  description = "The api revision."
}

# Api Gateway
variable "protocol" {
  default = "https"
}

variable "basic_auth_password" {
  default = ""
}

variable "basic_auth_username" {
  default = "test-user"
}

locals {
  apim_name      = "api-ms-${lower(var.environment_name_suffix)}-${lower(var.region_short_name)}-${lower(var.project_name)}-${var.resource_suffix}"
  frontdoor_name = "azu-ft-${lower(var.environment_name_suffix)}-${lower(var.region_short_name)}-${lower(var.project_name)}-${var.resource_suffix}"
  shared-rg = "RG-${upper(var.terraform_rg_suffix)}-${upper(var.region_short_name)}-${upper(var.project_name)}-${var.resource_suffix}"
}