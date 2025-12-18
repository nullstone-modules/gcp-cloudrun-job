resource "google_service_account" "app" {
  account_id   = local.resource_name
  display_name = "Service Account for Nullstone App ${local.app_name}"
}

// See https://cloud.google.com/kubernetes-engine/docs/tutorials/workload-identity-secrets
resource "google_secret_manager_secret_iam_member" "secrets_access" {
  for_each = local.secret_keys

  secret_id = google_secret_manager_secret.app_secret[each.key].secret_id
  project   = local.project_id
  role      = "roles/secretmanager.secretAccessor"
  member    = "serviceAccount:${google_service_account.app.email}"
}
