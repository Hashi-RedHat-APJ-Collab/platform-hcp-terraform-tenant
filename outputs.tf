
output "tfe_organization_name" {
  value = data.tfe_organization.this.name
}


output "tfe_project_name" {
  value = tfe_project.this
}