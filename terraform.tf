terraform {
  cloud {
    organization = "szubersk"

    workspaces {
      name = "github-configuration"
    }
  }

  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
  }

  required_version = ">= 1.11"
}
