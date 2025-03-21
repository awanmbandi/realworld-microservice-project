mock_provider "azurerm" {}

run "test_outputs" {
  command = plan

  assert {
    condition     = output.metadata_container_name == azurerm_storage_container.flyte_metadata.name
    error_message = "Incorrect Flyte metadata container name output"
  }

  assert {
    condition     = output.data_container_name == azurerm_storage_container.flyte_data.name
    error_message = "Incorrect Flyte data container name output"
  }

  assert {
    condition     = output.storage_account_name == azurerm_storage_account.flyte.name
    error_message = "Incorrect Flyte storage account name output"
  }
}
