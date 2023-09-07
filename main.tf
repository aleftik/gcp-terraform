terraform {
  required_providers {
    lacework = {
      source  = "lacework/lacework"
      version = "~> 1.0"
    }
  }
}

provider "google" {
  project = "lw-product-team"
}

module "gcp_project_level_config" {
  source  = "lacework/config/gcp"
  version = "~> 2.3"
}

module "gcp_project_audit_log" {
  source                       = "lacework/pub-sub-audit-log/gcp"
  version                      = "~> 0.2"
  lacework_integration_name    = "AuditLogIntegName"
  service_account_name         = module.gcp_project_level_config.service_account_name
  service_account_private_key  = module.gcp_project_level_config.service_account_private_key
  use_existing_service_account = true
}
