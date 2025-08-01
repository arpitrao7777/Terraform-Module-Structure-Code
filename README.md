### 🚀 Terraform Azure Infrastructure – Modular Architecture

This repository follows a **modular Terraform design** to deploy a structured Azure infrastructure. It leverages a **parent module** to orchestrate provisioning of various Azure components through reusable child modules. The `terraform.tfvars` file in the environment directory holds all required input variables, making it easier to manage configurations and environments like `dev`, `qa`, or `prod`.

### 📁 Structure Overview

* **Parent module (`main.tf`)** calls several child modules:

  * `azurerm_resourcegroup`
  * `azurerm_storageaccount`
  * `azurerm_virtualnetwork`
  * `azurerm_subnet`
  * `azurerm_bastion`
  * `azurerm_virtualmachine`
  * `azurerm_keyvault`

* **Dependencies** are handled using the `depends_on` argument to enforce provisioning order (e.g., subnets depend on virtual networks, which in turn depend on resource groups).

* On executing `terraform apply`, the configuration reads the `terraform.tfvars` file and provisions the full infrastructure stack in Azure with proper dependencies and isolation.

### ✅ Highlights

* Modular, reusable, and scalable Terraform architecture.
* Separation of concerns using individual modules per resource type.
* Easy environment switching with consistent variable structure.
* Declarative dependency handling with `depends_on`.
