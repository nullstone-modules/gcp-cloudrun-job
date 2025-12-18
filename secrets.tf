resource "google_secret_manager_secret" "app_secret" {
  for_each = local.secret_keys

  // Valid secret_id: [[a-zA-Z_0-9]+]
  secret_id = lower(replace("${local.resource_name}_${each.value}", "/[^a-zA-Z_0-9]/", "_"))
  labels    = local.labels

  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "app_secret" {
  for_each = local.secret_keys

  secret      = google_secret_manager_secret.app_secret[each.value].id
  secret_data = local.all_secrets[each.value]
}

locals {
  managed_secret_refs = { for key in local.secret_keys : key => google_secret_manager_secret.app_secret[key].name }

  existing_secret_keys = keys(data.ns_env_variables.this.secret_refs)
  all_secret_keys      = toset(concat(tolist(local.secret_keys), local.existing_secret_keys))
}
