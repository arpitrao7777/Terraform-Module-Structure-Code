module "rg_module" {
  source = "../../modules/azurerm_resourcegroup"
  rgs    = var.rg_details
}

module "stq_module" {
  depends_on = [module.rg_module]
  source     = "../../modules/azurerm_storageaccount"
  stqs       = var.stq_details
}

module "vn_module" {
  depends_on = [module.rg_module]
  source     = "../../modules/azurerm_virtualnetwork"
  vns        = var.vn_details
}

module "sb_module" {
  depends_on = [module.vn_module]
  source     = "../../modules/azurerm_subnet"
  sbs        = var.sb_details
}

module "bas_module" {
  depends_on = [module.sb_module]
  source     = "../../modules/azurerm_bastion"
  bas        = var.bas_details
}

module "vm_module" {
  depends_on = [module.kv_module]
  source     = "../../modules/azurerm_virtualmachine"
  vms        = var.vm_details
}

module "kv_module" {
  depends_on = [module.rg_module]
  source     = "../../modules/azurerm_keyvault"
  kvs        = var.kv_details
}
