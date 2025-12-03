locals {
  job_name            = local.resource_name
  main_container_name = "main"
  command             = length(var.command) > 0 ? var.command : null
}

resource "google_cloud_run_v2_job" "this" {
  name     = local.job_name
  location = local.region
  labels   = local.labels

  template {
    task_count      = 1
    parallelism     = var.parallelism
    service_account = google_service_account.app.email
    labels          = local.labels

    template {
      execution_environment = "EXECUTION_ENVIRONMENT_GEN2"
      timeout               = "${var.timeout_seconds}s"
      max_retries           = 1

      vpc_access {
        connector = local.vpc_access_connector
        egress    = "ALL_TRAFFIC"
      }

      containers {
        name    = local.main_container_name
        image   = "${local.repository_url}:${local.app_version}"
        command = local.command

        resources {
          limits = {
            cpu    = var.cpu
            memory = var.memory
          }
        }

        # Environment variables
        dynamic "env" {
          for_each = local.all_env_vars

          content {
            name  = env.key
            value = env.value
          }
        }

        # Secret environment variables
        dynamic "env" {
          for_each = local.all_secret_refs

          content {
            name = env.key

            value_source {
              secret_key_ref {
                secret  = env.value
                version = "latest"
              }
            }
          }
        }
      }
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}
