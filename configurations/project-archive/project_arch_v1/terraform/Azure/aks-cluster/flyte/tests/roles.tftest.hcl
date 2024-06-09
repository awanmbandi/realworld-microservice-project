mock_provider "azurerm" {}

run "test_roles" {
  command = plan

  assert {
    condition = azurerm_role_definition.flyte_metadata.permissions[0].data_actions == toset([
      "Microsoft.Storage/storageAccounts/blobServices/containers/blobs/read",
      "Microsoft.Storage/storageAccounts/blobServices/containers/blobs/write",
      "Microsoft.Storage/storageAccounts/blobServices/containers/blobs/add/action",
    ])
    error_message = "Incorrect Flyte metadata role permissions"
  }

  assert {
    condition = azurerm_role_definition.flyte_data.permissions[0].data_actions == toset([
      "Microsoft.Storage/storageAccounts/blobServices/containers/blobs/read",
      "Microsoft.Storage/storageAccounts/blobServices/containers/blobs/write",
      "Microsoft.Storage/storageAccounts/blobServices/containers/blobs/add/action",
    ])
    error_message = "Incorrect Flyte data role permissions"
  }

  assert {
    condition = azurerm_role_definition.flyte_sas.permissions[0].actions == tolist([
      "Microsoft.Storage/storageAccounts/blobServices/generateUserDelegationKey/action",
    ])
    error_message = "Incorrect Flyte SAS role permissions"
  }
}
