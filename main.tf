
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