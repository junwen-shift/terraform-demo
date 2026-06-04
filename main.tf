locals {
  default_tags = {
    project     = var.project
    environment = var.environment
    managed_by  = "terraform"
  }

  tags = merge(local.default_tags, var.extra_tags)
}

# ── Random pet name (demo resource) ─────────────────────────────────────────
resource "random_pet" "main" {
  length    = 2
  separator = "-"
}

# ── Random ID ────────────────────────────────────────────────────────────────
resource "random_id" "main" {
  byte_length = 4
}

# ── Null resource with triggers ──────────────────────────────────────────────
resource "null_resource" "main" {
  triggers = {
    pet_name = random_pet.main.id
    rand_id  = random_id.main.hex
  }
}

# ── Local file output ────────────────────────────────────────────────────────
resource "local_file" "metadata" {
  filename = "${path.module}/generated/metadata.json"
  content = jsonencode({
    project     = var.project
    environment = var.environment
    pet_name    = random_pet.main.id
    random_id   = random_id.main.hex
    tags        = local.tags
  })
}
