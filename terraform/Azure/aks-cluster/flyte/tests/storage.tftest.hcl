mock_provider "azurerm" {}

run "test_storage" {
  command = plan

  assert {
    condition     = azurerm_storage_account.flyte.name == "test12345flyte"
    error_message = "Incorrect Flyte storage account name"
  }

  assert {
    condition     = azurerm_storage_account.flyte.blob_properties[0].cors_rule[0].allowed_headers[0] == "x-ms-*"
    error_message = "Incorrect allowed headers for Flyte CORS rule"
  }

  assert {
    condition     = azurerm_storage_account.flyte.blob_properties[0].cors_rule[0].allowed_methods[0] == "GET"
    error_message = "Incorrect allowed methods in Flyte CORS rule"
  }

  assert {
    condition     = azurerm_storage_account.flyte.blob_properties[0].cors_rule[0].allowed_methods[1] == "HEAD"
    error_message = "Incorrect allowed methods in Flyte CORS rule"
  }

  assert {
    condition     = azurerm_storage_account.flyte.blob_properties[0].cors_rule[0].allowed_origins[0] == "*"
    error_message = "Incorrect allowed origins in Flyte CORS rule"
  }

  assert {
    condition     = azurerm_storage_account.flyte.blob_properties[0].cors_rule[0].exposed_headers[0] == ""
    error_message = "Incorrect exposed headers in Flyte CORS rule"
  }

  assert {
    condition     = azurerm_storage_account.flyte.blob_properties[0].cors_rule[0].max_age_in_seconds == 300
    error_message = "Incorrect max age in Flyte CORS rule"
  }

  assert {
    condition     = azurerm_storage_container.flyte_metadata.name == "${var.deploy_id}-flyte-metadata"
    error_message = "Incorrect flyte-metadata storage container name"
  }

  assert {
    condition     = azurerm_storage_container.flyte_metadata.storage_account_name == azurerm_storage_account.flyte.name
    error_message = "Incorrect storage account name for flyte-metadata storage container"
  }

  assert {
    condition     = azurerm_storage_container.flyte_data.name == "${var.deploy_id}-flyte-data"
    error_message = "Incorrect flyte-data storage container name"
  }

  assert {
    condition     = azurerm_storage_container.flyte_data.storage_account_name == azurerm_storage_account.flyte.name
    error_message = "Incorrect storage account name for flyte-data storage container"
  }
}
