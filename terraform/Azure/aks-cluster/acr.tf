resource "azurerm_container_registry" "domino" {
  #checkov:skip=CKV_AZURE_237: "Ensure dedicated data endpoints are enabled."
  name                = replace("${data.azurerm_resource_group.aks.name}domino", "/[^a-zA-Z0-9]/", "")
  resource_group_name = data.azurerm_resource_group.aks.name
  location            = data.azurerm_resource_group.aks.location

  sku           = var.registry_tier
  admin_enabled = false

  # Premium only
  public_network_access_enabled = var.registry_tier == "Premium" ? false : true

  zone_redundancy_enabled = var.registry_tier == "Premium"

  retention_policy {
    # Premium only
    enabled = var.registry_tier == "Premium"
  }

  tags = var.tags
}

resource "azurerm_role_assignment" "aks_domino_acr" {
  scope                = azurerm_container_registry.domino.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
}

resource "azurerm_role_assignment" "hephaestus_acr" {
  scope                = azurerm_container_registry.domino.id
  role_definition_name = "AcrPush"
  principal_id         = azurerm_user_assigned_identity.hephaestus.principal_id
}
