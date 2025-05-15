terraform {
  required_providers {

    tfe = {
      source = "hashicorp/tfe"
      version = "0.65.4-alpha.1"
    }
    
  }
}


provider "tfe" {
  hostname = "app.terraform.io"
  organization = var.tfe_organization_name
}