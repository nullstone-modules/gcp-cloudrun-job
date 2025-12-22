resource "google_service_account" "app" {
  account_id   = local.resource_name
  display_name = "Service Account for Nullstone App ${local.app_name}"
}

// See https://cloud.google.com/kubernetes-engine/docs/tutorials/workload-identity-secrets
resource "google_secret_manager_secret_iam_member" "secrets_access" {
  for_each = local.all_secret_keys

  secret_id = local.all_secrets[each.value]
  project   = local.project_id
  role      = "roles/secretmanager.secretAccessor"
  member    = "serviceAccount:${google_service_account.app.email}"
}

resource "google_artifact_registry_repository_iam_member" "app_pull_image" {
  project    = google_artifact_registry_repository.this.project
  location   = google_artifact_registry_repository.this.location
  repository = google_artifact_registry_repository.this.repository_id
  role       = "roles/artifactregistry.reader"
  member     = "serviceAccount:${google_service_account.app.email}"
}

resource "google_artifact_registry_repository_iam_member" "deployer_pull_image" {
  project    = google_artifact_registry_repository.this.project
  location   = google_artifact_registry_repository.this.location
  repository = google_artifact_registry_repository.this.repository_id
  role       = "roles/artifactregistry.reader"
  member     = "serviceAccount:${google_service_account.deployer.email}"
}
