mock_provider "azurerm" {}

run "test_identities" {
  command = plan

  assert {
    condition     = azurerm_user_assigned_identity.flyte_controlplane.name == "${var.deploy_id}-flyte-controlplane"
    error_message = "Incorrect user-assigned identity name for flyte_controlplane"
  }

  assert {
    condition     = azurerm_user_assigned_identity.flyte_controlplane.resource_group_name == var.resource_group_name
    error_message = "Incorrect user-assigned identity resource group name for flyte_controlplane"
  }

  assert {
    condition     = azurerm_user_assigned_identity.flyte_dataplane.name == "${var.deploy_id}-flyte-dataplane"
    error_message = "Incorrect user-assigned identity name for flyte_dataplane"
  }

  assert {
    condition     = azurerm_user_assigned_identity.flyte_dataplane.resource_group_name == var.resource_group_name
    error_message = "Incorrect user-assigned identity resource group name for flyte_dataplane"
  }

  assert {
    condition     = azurerm_federated_identity_credential.this["flyteadmin"].name == "${var.deploy_id}-flyteadmin"
    error_message = "Incorrect federated identity credential name for flyteadmin"
  }

  assert {
    condition     = azurerm_federated_identity_credential.this["flyteadmin"].subject == "system:serviceaccount:${var.namespaces.platform}:${var.service_account_names.flyteadmin}"
    error_message = "Incorrect federated identity credential subject for flyteadmin"
  }

  assert {
    condition     = azurerm_federated_identity_credential.this["flytepropeller"].name == "${var.deploy_id}-flytepropeller"
    error_message = "Incorrect federated identity credential name for flytepropeller"
  }

  assert {
    condition     = azurerm_federated_identity_credential.this["flytepropeller"].subject == "system:serviceaccount:${var.namespaces.platform}:${var.service_account_names.flytepropeller}"
    error_message = "Incorrect federated identity credential subject for flytepropeller"
  }

  assert {
    condition     = azurerm_federated_identity_credential.this["datacatalog"].name == "${var.deploy_id}-datacatalog"
    error_message = "Incorrect federated identity credential name for datacatalog"
  }

  assert {
    condition     = azurerm_federated_identity_credential.this["datacatalog"].subject == "system:serviceaccount:${var.namespaces.platform}:${var.service_account_names.datacatalog}"
    error_message = "Incorrect federated identity credential subject for datacatalog"
  }

  assert {
    condition     = azurerm_federated_identity_credential.this["nucleus"].name == "${var.deploy_id}-nucleus"
    error_message = "Incorrect federated identity credential name for nucleus"
  }

  assert {
    condition     = azurerm_federated_identity_credential.this["nucleus"].subject == "system:serviceaccount:${var.namespaces.platform}:${var.service_account_names.nucleus}"
    error_message = "Incorrect federated identity credential subject for nucleus"
  }
}
