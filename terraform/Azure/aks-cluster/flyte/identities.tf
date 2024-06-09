locals {
  # Kubernetes service account to user-assigned managed identity mapping
  federated_identity_mapping = {
    flyteadmin     = azurerm_user_assigned_identity.flyte_dataplane.id
    flytepropeller = azurerm_user_assigned_identity.flyte_controlplane.id
    datacatalog    = azurerm_user_assigned_identity.flyte_controlplane.id
    nucleus        = azurerm_user_assigned_identity.flyte_dataplane.id
  }
}

resource "azurerm_user_assigned_identity" "flyte_controlplane" {
  name                = "${var.deploy_id}-flyte-controlplane"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_user_assigned_identity" "flyte_dataplane" {
  name                = "${var.deploy_id}-flyte-dataplane"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_federated_identity_credential" "this" {
  for_each            = local.federated_identity_mapping
  name                = "${var.deploy_id}-${each.key}"
  resource_group_name = var.resource_group_name
  audience            = ["api://AzureADTokenExchange"]
  issuer              = var.oidc_issuer_url
  parent_id           = each.value
  subject             = "system:serviceaccount:${var.namespaces.platform}:${var.service_account_names[each.key]}"
}
