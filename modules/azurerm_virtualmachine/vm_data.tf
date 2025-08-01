data "azurerm_subnet" "frontend_subnet" {
  for_each             = var.vms
  name                 = each.value.subnet_name
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.resource_group_name
}

# data "azurerm_key_vault_secret" "username" {
#   name         = "adminusername"
#   key_vault_id = data.azurerm_key_vault.key-vault.id
# }

# data "azurerm_key_vault_secret" "password" {
#   name         = "adminpassword"
#   key_vault_id = data.azurerm_key_vault.key-vault.id
# }