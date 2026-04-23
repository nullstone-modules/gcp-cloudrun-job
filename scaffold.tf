module "scaffold" {
  source = "registry.terraform.io/nullstone-modules/cloudrun-appscaffold/google"

  project_id             = local.project_id
  region                 = local.region
  app_name               = local.app_name
  block_ref              = local.block_ref
  resource_suffix        = random_string.resource_suffix.result
  repo_labels            = local.repo_labels
  op_impersonater_emails = [local.ns_agent_service_account_email]
}

# State migration: move pre-refactor resources into the scaffold module address
# so existing workspaces don't destroy/recreate the artifact registry (which
# would lose all pushed images) or cycle any of the operator service accounts.

moved {
  from = google_artifact_registry_repository.this
  to   = module.scaffold.google_artifact_registry_repository.this
}

moved {
  from = google_service_account.app
  to   = module.scaffold.google_service_account.app
}

moved {
  from = google_service_account_iam_member.app_generate_token_self
  to   = module.scaffold.google_service_account_iam_member.app_generate_token_self
}

moved {
  from = google_artifact_registry_repository_iam_member.app_pull_image
  to   = module.scaffold.google_artifact_registry_repository_iam_member.app_pull_image
}

moved {
  from = google_artifact_registry_repository_iam_member.deployer_pull_image
  to   = module.scaffold.google_artifact_registry_repository_iam_member.deployer_pull_image
}

moved {
  from = google_service_account.image_pusher
  to   = module.scaffold.google_service_account.image_pusher
}

moved {
  from = google_artifact_registry_repository_iam_member.image_pusher_writer
  to   = module.scaffold.google_artifact_registry_repository_iam_member.image_pusher_writer
}

moved {
  from = google_artifact_registry_repository_iam_member.image_pusher_reader
  to   = module.scaffold.google_artifact_registry_repository_iam_member.image_pusher_reader
}

moved {
  from = google_service_account_iam_binding.image_pusher_nullstone_agent
  to   = module.scaffold.google_service_account_iam_binding.image_pusher_impersonators
}

moved {
  from = google_service_account.deployer
  to   = module.scaffold.google_service_account.deployer
}

moved {
  from = google_project_iam_member.deployer_update_access
  to   = module.scaffold.google_project_iam_member.deployer_update_access
}

moved {
  from = google_project_iam_member.deployer_invoker_access
  to   = module.scaffold.google_project_iam_member.deployer_invoker_access
}

moved {
  from = google_service_account_iam_member.deployer_act_as_runtime
  to   = module.scaffold.google_service_account_iam_member.deployer_act_as_runtime
}

moved {
  from = google_service_account_iam_binding.deployer_nullstone_agent
  to   = module.scaffold.google_service_account_iam_binding.deployer_impersonators
}

moved {
  from = google_service_account.log_reader
  to   = module.scaffold.google_service_account.log_reader
}

moved {
  from = google_project_iam_member.log_reader_logs_access
  to   = module.scaffold.google_project_iam_member.log_reader_logs_access
}

moved {
  from = google_service_account_iam_binding.log_reader_nullstone_agent
  to   = module.scaffold.google_service_account_iam_binding.log_reader_impersonators
}

moved {
  from = google_project_iam_member.deployer_metrics_viewer
  to   = module.scaffold.google_project_iam_member.deployer_metrics_viewer
}
