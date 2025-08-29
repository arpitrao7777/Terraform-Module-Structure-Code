# 🚀 Terraform Azure Infrastructure – Modular Architecture with CI/CD Pipeline

This repository follows a **modular Terraform design** to deploy a structured Azure infrastructure. It leverages a **parent module** to orchestrate provisioning of various Azure components through reusable child modules. The `terraform.tfvars` file in the environment directory holds all required input variables, making it easier to manage configurations and environments like `dev`, `qa`, or `prod`.

---

## 📁 Structure Overview

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

---

## ⚡ CI/CD Pipeline Integration

This repo also includes an **automated pipeline** to ensure smooth infrastructure deployments:

- **Trigger:** The pipeline is automatically triggered on every push/merge to the `main` branch.  
- **Stages:**
  1. **Lint & Validate:** Runs `terraform fmt` and `terraform validate` to ensure code consistency.  
  2. **Plan:** Executes `terraform plan` to preview infrastructure changes.  
  3. **Apply (Manual Approval):** Provisions infrastructure using `terraform apply` with an approval gate for safety.  
  4. **Destroy (Optional):** Can be triggered manually for cleanup.  

This CI/CD flow ensures that infrastructure code changes are properly validated, tested, and deployed in a controlled manner.

---

## ✅ Highlights

* Modular, reusable, and scalable Terraform architecture.  
* Separation of concerns using individual modules per resource type.  
* Easy environment switching with consistent variable structure.  
* Declarative dependency handling with `depends_on`.  
* Automated deployments via **pipeline with triggers and stages** for safer and faster provisioning.  

---
