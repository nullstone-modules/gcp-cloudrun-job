data "google_service_account_access_token" "gar" {
  target_service_account = google_service_account.image_pusher.email
  scopes                 = ["https://www.googleapis.com/auth/cloud-platform"]
  lifetime               = "3600s"
}

provider "dockerless" {
  registry_auth = {
    "${google_artifact_registry_repository.this.location}-docker.pkg.dev" = {
      username = "oauth2accesstoken"
      password = data.google_service_account_access_token.gar.access_token
    }
  }
}

// This pulls a Nullstone-managed bootstrap image, retags, and pushes it
resource "dockerless_remote_image" "bootstrap" {
  source = "nullstone/cloudrun-bootstrap:latest"
  target = "${local.repository_url}:bootstrap"
}
