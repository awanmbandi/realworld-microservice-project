# terraform-azure-aks
Terraform module for deploying a Domino on AKS

## Use

### Create a Domino development AKS cluster
```hcl
module "aks_cluster" {
  source  = "github.com/dominodatalab/terraform-azure-aks"

  cluster = "cluster-name"
}
```

## Manual Deploy
For new projects, the following needs to be done only once for the workspace.
1. `az login`
1. `terraform init`
1. `terraform workspace new [cluster-name]`

Run the Terraform deployment
1. `export TF_VAR_service_principal_name=<service-principal-appid>`
1. `export TF_VAR_service_principal_secret=<service-principal-password>`
1. `terraform apply -auto-approve`

Access AKS cluster
1. `az aks get-credentials --resource-group [cluster-name] --name [cluster-name]`

### Troubleshooting

1. No access to Azure backend store
  In this case you would need to override the backend configuration. This can be done
  via the command line:
  ```
  terraform init -backend-config="storage_account_name=<YourAzureStorageAccountName>" -backend-config="container_name=tfstate" -backend-config="access_key=<YourStorageAccountAccessKey>" -backend-config="key=codelab.microsoft.tfstate"
  ```

## Development

Please submit any feature enhancements, bug fixes, or ideas via pull requests or issues.
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.45 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 3.45 |
| <a name="provider_random"></a> [random](#provider\_random) | ~> 3.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_container_registry.domino](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry) | resource |
| [azurerm_federated_identity_credential.hephaestus](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/federated_identity_credential) | resource |
| [azurerm_federated_identity_credential.importer](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/federated_identity_credential) | resource |
| [azurerm_kubernetes_cluster.aks](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster) | resource |
| [azurerm_kubernetes_cluster_node_pool.aks](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster_node_pool) | resource |
| [azurerm_log_analytics_solution.logs](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_solution) | resource |
| [azurerm_log_analytics_workspace.logs](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_workspace) | resource |
| [azurerm_monitor_diagnostic_setting.control_plane](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_role_assignment.aks_domino_acr](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.aks_network](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.hephaestus_acr](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_storage_account.domino](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_storage_container.domino_containers](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_user_assigned_identity.hephaestus](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity) | resource |
| [random_id.log_analytics_workspace_name_suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [azurerm_kubernetes_service_versions.selected](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/kubernetes_service_versions) | data source |
| [azurerm_resource_group.aks](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_node_pools"></a> [additional\_node\_pools](#input\_additional\_node\_pools) | additional node pools | <pre>map(object({<br>    enable_node_public_ip = optional(bool, false)<br>    vm_size               = string<br>    zones                 = list(string)<br>    node_labels           = map(string)<br>    node_os               = optional(string, "AzureLinux")<br>    node_taints           = optional(list(string), [])<br>    enable_auto_scaling   = optional(bool, true)<br>    min_count             = optional(number, 0)<br>    max_count             = number<br>    initial_count         = optional(number, 0)<br>    max_pods              = optional(number, 30)<br>    os_disk_size_gb       = optional(number, 128)<br>  }))</pre> | `{}` | no |
| <a name="input_api_server_authorized_ip_ranges"></a> [api\_server\_authorized\_ip\_ranges](#input\_api\_server\_authorized\_ip\_ranges) | The IP ranges to whitelist for incoming traffic to the masters | `list(string)` | n/a | yes |
| <a name="input_cluster_sku_tier"></a> [cluster\_sku\_tier](#input\_cluster\_sku\_tier) | The Domino cluster SKU (defaults to Free) | `string` | `null` | no |
| <a name="input_cni_overlay_enabled"></a> [cni\_overlay\_enabled](#input\_cni\_overlay\_enabled) | Flag to determine whether to use overlay network settings | `bool` | `false` | no |
| <a name="input_containers"></a> [containers](#input\_containers) | storage containers to create | <pre>map(object({<br>    container_access_type = string<br>  }))</pre> | <pre>{<br>  "backups": {<br>    "container_access_type": "private"<br>  },<br>  "projects": {<br>    "container_access_type": "private"<br>  }<br>}</pre> | no |
| <a name="input_deploy_id"></a> [deploy\_id](#input\_deploy\_id) | Domino Deployment ID. | `string` | n/a | yes |
| <a name="input_dns_service_ip"></a> [dns\_service\_ip](#input\_dns\_service\_ip) | IP address assigned to the Kubernetes DNS service, used when CNI Overlay is enabled | `string` | `"100.97.0.10"` | no |
| <a name="input_kubeconfig_output_path"></a> [kubeconfig\_output\_path](#input\_kubeconfig\_output\_path) | kubeconfig path | `string` | n/a | yes |
| <a name="input_kubernetes_nat_gateway"></a> [kubernetes\_nat\_gateway](#input\_kubernetes\_nat\_gateway) | Managed NAT Gateway configuration | <pre>object({<br>    idle_timeout_in_minutes   = optional(number, 4)<br>    managed_outbound_ip_count = number<br>    }<br>  )</pre> | `null` | no |
| <a name="input_kubernetes_version"></a> [kubernetes\_version](#input\_kubernetes\_version) | Optional Kubernetes version to provision. Allows partial input (e.g. 1.18) which is then chosen from azurerm\_kubernetes\_service\_versions. | `string` | `null` | no |
| <a name="input_log_analytics_workspace_sku"></a> [log\_analytics\_workspace\_sku](#input\_log\_analytics\_workspace\_sku) | log analytics sku | `string` | `"PerGB2018"` | no |
| <a name="input_namespaces"></a> [namespaces](#input\_namespaces) | Namespace that are used for generating the service account bindings | `object({ platform = string, compute = string })` | n/a | yes |
| <a name="input_node_pools"></a> [node\_pools](#input\_node\_pools) | default node pools | <pre>object({<br>    compute = object({<br>      enable_node_public_ip = optional(bool, false)<br>      vm_size               = optional(string, "Standard_D8s_v4")<br>      zones                 = optional(list(string), ["1", "2", "3"])<br>      node_labels = optional(map(string), {<br>        "dominodatalab.com/node-pool" = "default"<br>      })<br>      node_os             = optional(string, "AzureLinux")<br>      node_taints         = optional(list(string), [])<br>      enable_auto_scaling = optional(bool, true)<br>      min_count           = optional(number, 0)<br>      max_count           = optional(number, 10)<br>      initial_count       = optional(number, 1)<br>      max_pods            = optional(number, 30)<br>      os_disk_size_gb     = optional(number, 128)<br>    }),<br>    platform = object({<br>      enable_node_public_ip = optional(bool, false)<br>      vm_size               = optional(string, "Standard_D8s_v4")<br>      zones                 = optional(list(string), ["1", "2", "3"])<br>      node_labels = optional(map(string), {<br>        "dominodatalab.com/node-pool" = "platform"<br>      })<br>      node_os             = optional(string, "AzureLinux")<br>      node_taints         = optional(list(string), [])<br>      enable_auto_scaling = optional(bool, true)<br>      min_count           = optional(number, 1)<br>      max_count           = optional(number, 3)<br>      initial_count       = optional(number, 1)<br>      max_pods            = optional(number, 60)<br>      os_disk_size_gb     = optional(number, 128)<br>    }),<br>    gpu = object({<br>      enable_node_public_ip = optional(bool, false)<br>      vm_size               = optional(string, "Standard_NC6s_v3")<br>      zones                 = optional(list(string), [])<br>      node_labels = optional(map(string), {<br>        "dominodatalab.com/node-pool" = "default-gpu"<br>        "nvidia.com/gpu"              = "true"<br>      })<br>      node_os = optional(string, "AzureLinux")<br>      node_taints = optional(list(string), [<br>        "nvidia.com/gpu=true:NoExecute"<br>      ])<br>      enable_auto_scaling = optional(bool, true)<br>      min_count           = optional(number, 0)<br>      max_count           = optional(number, 1)<br>      initial_count       = optional(number, 0)<br>      max_pods            = optional(number, 30)<br>      os_disk_size_gb     = optional(number, 128)<br>    })<br>    system = object({<br>      enable_node_public_ip = optional(bool, false)<br>      vm_size               = optional(string, "Standard_DS4_v2")<br>      zones                 = optional(list(string), ["1", "2", "3"])<br>      node_labels           = optional(map(string), {})<br>      node_os               = optional(string, "AzureLinux")<br>      node_taints           = optional(list(string), [])<br>      enable_auto_scaling   = optional(bool, true)<br>      min_count             = optional(number, 1)<br>      max_count             = optional(number, 6)<br>      initial_count         = optional(number, 1)<br>      max_pods              = optional(number, 60)<br>      os_disk_size_gb       = optional(number, 128)<br>    })<br>  })</pre> | <pre>{<br>  "compute": {},<br>  "gpu": {},<br>  "platform": {},<br>  "system": {}<br>}</pre> | no |
| <a name="input_pod_cidr"></a> [pod\_cidr](#input\_pod\_cidr) | CIDR block for Kubernetes pods, used when CNI Overlay is enabled | `string` | `"192.168.0.0/16"` | no |
| <a name="input_registry_tier"></a> [registry\_tier](#input\_registry\_tier) | registry tier | `string` | `"Standard"` | no |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | Name or id of optional pre-existing resource group to install AKS in | `string` | n/a | yes |
| <a name="input_service_cidr"></a> [service\_cidr](#input\_service\_cidr) | CIDR block for Kubernetes services, used  when CNI Overlay is enabled | `string` | `"100.97.0.0/16"` | no |
| <a name="input_storage_account_replication_type"></a> [storage\_account\_replication\_type](#input\_storage\_account\_replication\_type) | storage replication | `string` | `"LRS"` | no |
| <a name="input_storage_account_tier"></a> [storage\_account\_tier](#input\_storage\_account\_tier) | storage account tier | `string` | `"Standard"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aks_identity"></a> [aks\_identity](#output\_aks\_identity) | AKS managed identity |
| <a name="output_containers"></a> [containers](#output\_containers) | storage details |
| <a name="output_domino_acr"></a> [domino\_acr](#output\_domino\_acr) | Azure Container Registry details |
| <a name="output_oidc_issuer_url"></a> [oidc\_issuer\_url](#output\_oidc\_issuer\_url) | OIDC issuer url |
| <a name="output_storage_account"></a> [storage\_account](#output\_storage\_account) | storage account |
| <a name="output_workload_identities"></a> [workload\_identities](#output\_workload\_identities) | service identities |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
