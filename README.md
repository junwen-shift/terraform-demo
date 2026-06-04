# terraform-demo

A demo Terraform project targeting **Azure**, with a full GitHub Actions CI/CD pipeline.

## Project Structure

```
.
├── providers.tf          # Terraform & AzureRM provider config
├── variables.tf          # Input variables
├── main.tf               # Resources (resource group + storage account)
├── outputs.tf            # Output values
├── .gitignore            # Standard Terraform ignores
└── .github/
    └── workflows/
        └── terraform.yml # GitHub Actions CI/CD pipeline
```

## Resources Deployed

| Resource | Name pattern |
|---|---|
| Resource Group | `rg-<project>-<environment>` |
| Storage Account | `st<project><environment>001` |

## GitHub Actions Pipeline

| Job | Triggered by | Purpose |
|---|---|---|
| **validate** | Every push / PR | `terraform fmt` + `terraform validate` |
| **plan** | Every push / PR | `terraform plan`; posts diff comment on PRs |
| **apply** | Push to `main` or manual dispatch (`apply`) | `terraform apply` from saved plan |
| **destroy** | Manual dispatch only (`destroy`) | `terraform destroy` with environment guard |

### Required Secrets

Set these in **Settings → Secrets → Actions**:

| Secret | Description |
|---|---|
| `AZURE_CLIENT_ID` | Service principal app ID |
| `AZURE_CLIENT_SECRET` | Service principal secret |
| `AZURE_TENANT_ID` | Azure AD tenant ID |
| `AZURE_SUBSCRIPTION_ID` | Target subscription ID |

### Environments

Create GitHub Environments (`dev`, `staging`, `prod`) for approval gates on apply/destroy.

## Local Usage

```bash
# Authenticate with Azure
az login
az account set --subscription "<your-subscription-id>"

# Init
terraform init

# Plan
terraform plan -var="subscription_id=<id>" -var="environment=dev"

# Apply
terraform apply -var="subscription_id=<id>" -var="environment=dev"
```

## Variables

| Name | Type | Default | Description |
|---|---|---|---|
| `subscription_id` | `string` | — | Azure subscription ID (required) |
| `location` | `string` | `West Europe` | Azure region |
| `environment` | `string` | `dev` | `dev` / `staging` / `prod` |
| `project` | `string` | `demo` | Short name used in resource naming |
| `resource_group_name` | `string` | `null` | Override the auto-generated RG name |
| `extra_tags` | `map(string)` | `{}` | Additional tags to merge |
