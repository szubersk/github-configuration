locals {
  default_branch_name = "master"
  repositories = toset([
    "dotfiles",
    "github-configuration",
    "szubersk",
    "szubersk.github.io",
    "userdata",
    "vm-images",
  ])
  repositories_without_pull_requests = toset([
    "dotfiles",
    "szubersk",
    "szubersk.github.io",
  ])
}
