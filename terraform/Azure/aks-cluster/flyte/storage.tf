resource "azurerm_storage_account" "flyte" {
  name                     = join("", [replace(var.deploy_id, "/[_-]/", ""), "flyte"])
  location                 = var.resource_group_location
  resource_group_name      = var.resource_group_name
  account_kind             = "StorageV2"
  account_tier             = var.storage_account_tier
  account_replication_type = var.storage_account_replication_type
  access_tier              = "Hot"
  min_tls_version          = "TLS1_2"
  tags                     = var.tags
  is_hns_enabled           = true

  blob_properties {
    cors_rule {
      allowed_headers    = ["x-ms-*"]
      allowed_methods    = ["GET", "HEAD"]
      allowed_origins    = ["*"]
      exposed_headers    = [""]
      max_age_in_seconds = 300
    }
  }
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_storage_container" "flyte_metadata" {
  name                  = "${var.deploy_id}-flyte-metadata"
  storage_account_name  = azurerm_storage_account.flyte.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "flyte_data" {
  name                  = "${var.deploy_id}-flyte-data"
  storage_account_name  = azurerm_storage_account.flyte.name
  container_access_type = "private"
}
