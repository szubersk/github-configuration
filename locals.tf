locals {
  default_branch_name = "master"
  repositories = toset([
    "dotfiles",
    "github-configuration",
    "runbook",
    "userdata",
    "vm-images",
  ])
  repositories_without_pull_requests = toset([
    "dotfiles",
  ])
}
