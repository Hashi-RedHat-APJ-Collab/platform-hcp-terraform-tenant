
variable "tfe_organization_name" {
  description = "TFE organization name"
  type        = string
}

variable "tfe_projects" {
  description = "Map of TFE projects to create"
  type        = map(object({
    name        = string
    description = string
  }))
  default     = {
    "project1" = {
      name        = "Demo Project - IaaS"
      description = "Description for Project 1"
    }
    "project2" = {
      name        = "Demo Project 2"
      description = "Description for Project 2"
    }
  }
}