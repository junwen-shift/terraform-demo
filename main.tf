locals {
  resource_group_name = coalesce(
    var.resource_group_name,
    "rg-${var.project}-${var.environment}"
  )

  default_tags = {
    project     = var.project
    environment = var.environment
    managed_by  = "terraform"
  }

  tags = merge(local.default_tags, var.extra_tags)
}

# ── Resource Group ────────────────────────────────────────────────────────────
resource "azurerm_resource_group" "main" {
  name     = local.resource_group_name
  location = var.location
  tags     = local.tags
}

# ── Storage Account (demo resource) ──────────────────────────────────────────
resource "azurerm_storage_account" "main" {
  name                     = "st${var.project}${var.environment}001"
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  blob_properties {
    delete_retention_policy {
      days = 7
    }
  }

  tags = local.tags
}
