resource "azurerm_network_interface" "nic" {
  for_each            = var.vms
  name                = each.value.nic_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                          = "ip1"
    subnet_id                     = data.azurerm_subnet.frontend_subnet[each.key].id
    private_ip_address_allocation = "Dynamic"
    # public_ip_address_id          = azurerm_public_ip.pip.id  # No need due to bastion
  }
}

data "azurerm_key_vault" "key-vault" {
  for_each            = var.vms
  name                = each.value.kv_name
  resource_group_name = each.value.resource_group_name
}

resource "random_password" "password" {
  for_each         = var.vms
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "azurerm_key_vault_secret" "password" {
  for_each     = var.vms
  name         = "${each.value.vm_name}-password"
  value        = random_password.password[each.key].result
  key_vault_id = data.azurerm_key_vault.key-vault[each.key].id
}

resource "azurerm_linux_virtual_machine" "vm" {
  for_each                        = var.vms
  name                            = each.value.vm_name
  resource_group_name             = each.value.resource_group_name
  location                        = each.value.location
  size                            = each.value.size
  admin_username                  = "devopsadmin"
  admin_password                  = azurerm_key_vault_secret.password[each.key].value
  disable_password_authentication = false
  network_interface_ids           = [azurerm_network_interface.nic[each.key].id, ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}
