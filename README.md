# terraform-demo

A demo Terraform project using **credential-free providers** to showcase Dependabot lockfile management and GitHub Actions CI/CD.

No cloud credentials required — all providers (`null`, `random`, `local`) run locally.

## Project Structure

```
.
├── providers.tf              # Terraform & provider version constraints
├── variables.tf              # Input variables
├── main.tf                   # Resources (random_pet, random_id, null_resource, local_file)
├── outputs.tf                # Output values
├── .terraform.lock.hcl       # Provider dependency lockfile (committed)
├── .gitignore
└── .github/
    ├── dependabot.yml        # Dependabot config for Terraform + Actions
    └── workflows/
        └── terraform.yml     # CI pipeline (validate → plan)
```

## Resources

| Resource | Purpose |
|---|---|
| `random_pet.main` | Generates a human-readable pet name |
| `random_id.main` | Generates a random hex identifier |
| `null_resource.main` | Demonstrates triggers and dependencies |
| `local_file.metadata` | Writes a JSON metadata file locally |

## Dependabot

Dependabot is configured to update **Terraform providers** and **GitHub Actions** weekly via `.terraform.lock.hcl`.

## Local Usage

```bash
terraform init
terraform plan
terraform apply
```

## Variables

| Name | Type | Default | Description |
|---|---|---|---|
| `environment` | `string` | `dev` | `dev` / `staging` / `prod` |
| `project` | `string` | `demo` | Short name used in resource naming |
| `extra_tags` | `map(string)` | `{}` | Additional tags to merge |
