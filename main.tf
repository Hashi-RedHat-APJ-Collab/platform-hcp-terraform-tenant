
data "tfe_organization" "this" {
  name = var.tfe_organization_name
}


# resource to create each tfe_project using map

resource "tfe_project" "this" {
  for_each = var.tfe_projects

  name        = each.value.name
  description = each.value.description
  organization = data.tfe_organization.this.name
}


# create a project variable set for each project scoped to the project
resource "tfe_variable_set" "this" {
  for_each = var.tfe_projects

  name        = "${each.value.name}-var-set"
  description = "${each.value.description} varset"
  organization = data.tfe_organization.this.name
  parent_project_id = tfe_project.this[each.key].id
}



resource "tfe_project_variable_set" "test" {
  for_each = var.tfe_projects
  
  variable_set_id = tfe_variable_set.this[each.key].id
  project_id      = tfe_project.this[each.key].id
  
}



# create a variable set for these values
# TFC_VAULT_ADDR
# https://production.vault.11eb56d6-0f95-3a99-a33c-0242ac110007.aws.hashicorp.cloud:8200/	env	None
# TFC_VAULT_AUTH_PATH
# jwt_tfc	env	None
# TFC_VAULT_NAMESPACE
# admin	env	None
# TFC_VAULT_PROVIDER_AUTH
# true	env	None
# TFC_VAULT_RUN_ROLE
# tfc	env	None
# TFC_VAULT_WORKLOAD_IDENTITY_AUDIENCE
# vault.tfc.workspace.identity	env	None
# create a variable set for these values including the above variables
resource "tfe_variable_set" "vault" {
  name        = "vault-jwt-set"
  description = "vault dynamic creds varset"
  organization = data.tfe_organization.this.name
}
resource "tfe_variable" "vault" {
  for_each = var.vault_variables

  key          = each.key
  value        = each.value
  category     = "env"
  sensitive    = false
  hcl          = false
  variable_set_id = tfe_variable_set.vault.id
}





resource "tfe_project" "consumer" {
  for_each = var.consumer_projects

  name        = each.value.name
  description = each.value.description
  organization = data.tfe_organization.this.name
}


resource "tfe_variable_set" "consumer" {
  for_each = var.consumer_projects

  name        = "${each.value.name}-var-set"
  description = "${each.value.description} varset"
  organization = data.tfe_organization.this.name
  parent_project_id = tfe_project.consumer[each.key].id
}


resource "tfe_project_variable_set" "consumer" {
  for_each = var.consumer_projects

  variable_set_id = tfe_variable_set.consumer[each.key].id
  project_id      = tfe_project.consumer[each.key].id

}
