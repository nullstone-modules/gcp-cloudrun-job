data "google_client_config" "this" {}
data "google_client_openid_userinfo" "this" {}

locals {
  region             = data.google_client_config.this.region
  zone               = data.google_client_config.this.zone
  project_id         = data.google_client_config.this.project
  executing_sa_email = data.google_client_openid_userinfo.this.email
}
