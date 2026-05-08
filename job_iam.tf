locals {
  cap_iam_members = {
    for item in local.capabilities.job_iam_members : "${local.cap_env_prefixes[item.cap_tf_id]}${item.name}" => item
  }
}

resource "google_cloud_run_v2_job_iam_member" "capability" {
  for_each = local.cap_iam_members

  project  = local.project_id
  location = local.region
  name     = google_cloud_run_v2_job.this.name
  role     = each.value.role
  member   = each.value.member
}
