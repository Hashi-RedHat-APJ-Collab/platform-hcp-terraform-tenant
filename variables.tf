
variable "tfe_organization_name" {
  description = "TFE organization name"
  type        = string
  default = "Hashi-RedHat-APJ-Collab"
}

variable "tfe_projects" {
  description = "Map of TFE projects to create"
  type        = map(object({
    name        = string
    description = string
  }))
  default     = {
    "project1" = {
      name        = "Demo Project IaaS"
      description = "Description for Project 1"
    }
  }
}

variable "vault_variables" {
  description = "Environment variables for Vault JWT authentication in Terraform Cloud"
  type        = map(string)
  default     = {
    TFC_VAULT_ADDR                      = "https://tf-aap-public-vault-76d1afab.7739a0fc.z1.hashicorp.cloud:8200"
    TFC_VAULT_AUTH_PATH                 = "jwt_tfc"
    TFC_VAULT_NAMESPACE                 = "admin/hashi-redhat"
    TFC_VAULT_PROVIDER_AUTH             = "true"
    TFC_VAULT_RUN_ROLE                  = "vault_admins"
    TFC_VAULT_WORKLOAD_IDENTITY_AUDIENCE = "vault.tfc.workspace.identity"
  }
}


variable "consumer_projects" {
  description = "Map of consumer projects to create"
  type        = map(object({
    name        = string
    description = string
  }))
  default     = {
    "Fred" = {
      name        = "FredsProject"
      description = "Fred's Project"
    }
    "Aaron" = {
      name        = "AaronsProject"
      description = "Aaron's Project"
    }
  }
}

variable "aap_variables" {
  description = "Environment variables for AAP in Terraform Cloud"
  type        = map(string)
  default     = {
    AAP_HOST = "https://aap.simon-lynch.sbx.hashidemos.io/"
    AAP_USERNAME = "admin"
  }
}