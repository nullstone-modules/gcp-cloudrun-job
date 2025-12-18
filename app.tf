data "ns_app_env" "this" {
  stack_id = data.ns_workspace.this.stack_id
  app_id   = data.ns_workspace.this.block_id
  env_id   = data.ns_workspace.this.env_id
}

locals {
  app_name    = data.ns_workspace.this.block_name
  app_version = data.ns_app_env.this.version
}

locals {
  app_metadata = tomap({
    // Inject app metadata into capabilities here (e.g. service_account_id)
    service_account_id    = google_service_account.app.id
    service_account_email = google_service_account.app.email
    job_id                = google_cloud_run_v2_job.this.id
    job_name              = google_cloud_run_v2_job.this.name
  })
}
