output "metadata_container_name" {
  value       = azurerm_storage_container.flyte_metadata.name
  description = "Flyte metadata storage container name"
}

output "data_container_name" {
  value       = azurerm_storage_container.flyte_data.name
  description = "Flyte data storage container name"
}

output "controlplane_client_id" {
  value       = azurerm_user_assigned_identity.flyte_controlplane.client_id
  description = "Flyte controlplane client id"
}

output "dataplane_client_id" {
  value       = azurerm_user_assigned_identity.flyte_dataplane.client_id
  description = "Flyte dataplane client id"
}

output "storage_account_name" {
  description = "Flyte storage account name"
  value       = azurerm_storage_account.flyte.name
}

output "storage_account_key" {
  description = "Flyte storage account key"
  value       = azurerm_storage_account.flyte.primary_access_key
  sensitive   = true
}
