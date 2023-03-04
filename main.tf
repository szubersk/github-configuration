resource "github_repository" "this" {
  for_each = local.repositories

  allow_auto_merge       = false
  allow_merge_commit     = false
  allow_rebase_merge     = true
  allow_squash_merge     = false
  allow_update_branch    = true
  archived               = false
  auto_init              = true
  delete_branch_on_merge = true
  has_discussions        = false
  has_downloads          = false
  has_issues             = true
  has_projects           = false
  has_wiki               = false
  name                   = each.value
  visibility             = "public"
  vulnerability_alerts   = true

  security_and_analysis {
    secret_scanning {
      status = "enabled"
    }

    secret_scanning_push_protection {
      status = "disabled"
    }
  }

  lifecycle {
    ignore_changes = [
      description,
      homepage_url,
      pages,
      topics,
    ]
  }
}

resource "github_branch_default" "this" {
  for_each = local.repositories

  repository = github_repository.this[each.value].name
  branch     = local.default_branch_name
}

resource "github_branch_protection" "this" {
  for_each = local.repositories

  allows_deletions                = false
  allows_force_pushes             = false
  blocks_creations                = false
  enforce_admins                  = true
  lock_branch                     = false
  pattern                         = local.default_branch_name
  push_restrictions               = []
  repository_id                   = github_repository.this[each.value].node_id
  require_conversation_resolution = true
  require_signed_commits          = false
  required_linear_history         = true

  dynamic "required_pull_request_reviews" {
    for_each = contains(local.repositories_without_pull_requests, github_repository.this[each.value].name) ? [] : [1]
    content {
      dismiss_stale_reviews           = true
      require_code_owner_reviews      = false
      require_last_push_approval      = false
      required_approving_review_count = 0
      restrict_dismissals             = false
    }
  }

  required_status_checks {
    contexts = []
    strict   = true
  }
}
