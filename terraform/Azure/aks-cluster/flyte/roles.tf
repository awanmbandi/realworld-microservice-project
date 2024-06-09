resource "azurerm_role_definition" "flyte_metadata" {
  name  = "${var.deploy_id}-flyte-metadata-role"
  scope = azurerm_storage_container.flyte_metadata.resource_manager_id
  permissions {
    data_actions = [
      "Microsoft.Storage/storageAccounts/blobServices/containers/blobs/read",
      "Microsoft.Storage/storageAccounts/blobServices/containers/blobs/write",
      "Microsoft.Storage/storageAccounts/blobServices/containers/blobs/add/action",
    ]
  }
}

resource "azurerm_role_definition" "flyte_data" {
  name  = "${var.deploy_id}-flyte-data-role"
  scope = azurerm_storage_container.flyte_data.resource_manager_id
  permissions {
    data_actions = [
      "Microsoft.Storage/storageAccounts/blobServices/containers/blobs/read",
      "Microsoft.Storage/storageAccounts/blobServices/containers/blobs/write",
      "Microsoft.Storage/storageAccounts/blobServices/containers/blobs/add/action",
    ]
  }
}

# Because the Get User Delegation Key operation acts at the level of the storage account, the
# Microsoft.Storage/storageAccounts/blobServices/generateUserDelegationKey action must be scoped at the level
# of the storage account, the resource group, or the subscription.
# https://learn.microsoft.com/en-us/rest/api/storageservices/get-user-delegation-key
#
resource "azurerm_role_definition" "flyte_sas" {
  name  = "${var.deploy_id}-flyte-sas-role"
  scope = azurerm_storage_account.flyte.id
  permissions {
    actions = [
      "Microsoft.Storage/storageAccounts/blobServices/generateUserDelegationKey/action",
    ]
  }
}

resource "azurerm_role_assignment" "flyte_metadata_controlplane" {
  scope              = azurerm_storage_container.flyte_metadata.resource_manager_id
  role_definition_id = azurerm_role_definition.flyte_metadata.role_definition_resource_id
  principal_id       = azurerm_user_assigned_identity.flyte_controlplane.principal_id
}

resource "azurerm_role_assignment" "flyte_metadata_dataplane" {
  scope              = azurerm_storage_container.flyte_metadata.resource_manager_id
  role_definition_id = azurerm_role_definition.flyte_metadata.role_definition_resource_id
  principal_id       = azurerm_user_assigned_identity.flyte_dataplane.principal_id
}

resource "azurerm_role_assignment" "flyte_data" {
  scope              = azurerm_storage_container.flyte_data.resource_manager_id
  role_definition_id = azurerm_role_definition.flyte_data.role_definition_resource_id
  principal_id       = azurerm_user_assigned_identity.flyte_dataplane.principal_id
}

resource "azurerm_role_assignment" "flyte_sas" {
  scope              = azurerm_storage_account.flyte.id
  role_definition_id = azurerm_role_definition.flyte_sas.role_definition_resource_id
  principal_id       = azurerm_user_assigned_identity.flyte_dataplane.principal_id
}
