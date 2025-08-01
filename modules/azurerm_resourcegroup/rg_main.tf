resource "azurerm_resource_group" "rg-001" {
  for_each = var.rgs
  name     = each.value.name
  location = each.value.location
}