
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


# create a project variable set for each project
resource "tfe_variable_set" "this" {
  for_each = var.tfe_projects

  name        = "${each.value.name}-var-set"
  description = "${each.value.description} varset"
  organization = data.tfe_organization.this.name
}



resource "tfe_project_variable_set" "test" {
  for_each = var.tfe_projects
  
  variable_set_id = tfe_variable_set.this[each.key].id
  project_id      = tfe_project.this[each.key].id
}