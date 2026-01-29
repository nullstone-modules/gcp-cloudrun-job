locals {
  metrics_mappings = concat(local.base_metrics, local.capabilities.metrics)

  // Resources
  // - https://cloud.google.com/stackdriver/docs/managed-prometheus/promql
  query_filter = "monitored_resource=\"cloud_run_job\",job_name=\"${local.job_name}\""

  base_metrics = [
    {
      name = "app/cpu"
      type = "usage"
      unit = "cores"

      mappings = {
        cpu_reserved = {
          query = "avg(run_googleapis_com_container_cpu_allocation_time{${local.query_filter}})"
        }
        cpu_average = {
          query = "(avg(run_googleapis_com_container_cpu_utilizations{${local.query_filter}}))*(avg(run_googleapis_com_container_cpu_allocation_time{${local.query_filter}}))"
        }
        cpu_min = {
          query = "(min(run_googleapis_com_container_cpu_utilizations{${local.query_filter}}))*(avg(run_googleapis_com_container_cpu_allocation_time{${local.query_filter}}))"
        }
        cpu_max = {
          query = "(max(run_googleapis_com_container_cpu_utilizations{${local.query_filter}}))*(avg(run_googleapis_com_container_cpu_allocation_time{${local.query_filter}}))"
        }
      }
    },
    {
      name = "app/memory"
      type = "usage"
      unit = "MiB"

      mappings = {
        memory_reserved = {
          query = "(avg(run_googleapis_com_container_memory_allocation_time{${local.query_filter}}))/1048576"
        }
        memory_average = {
          query = "(avg(run_googleapis_com_container_memory_utilizations{${local.query_filter}}))*(avg(run_googleapis_com_container_memory_allocation_time{${local.query_filter}}))/1048576"
        }
        memory_min = {
          query = "(min(run_googleapis_com_container_memory_utilizations{${local.query_filter}}))*(avg(run_googleapis_com_container_memory_allocation_time{${local.query_filter}}))/1048576"
        }
        memory_max = {
          query = "(max(run_googleapis_com_container_memory_utilizations{${local.query_filter}}))*(avg(run_googleapis_com_container_memory_allocation_time{${local.query_filter}}))/1048576"
        }
      }
    },
    {
      name = "invocations"
      type = "invocations"
      unit = "count"

      mappings = {
        invocations_total = {
          query = "sum(run_googleapis_com_job_completed_task_attempt_count{${local.query_filter}})"
        }
        invocations_failed = {
          query = "sum(run_googleapis_com_job_completed_task_attempt_count{${local.query_filter},status=\"failure\"})"
        }
      }
    },
  ]
}

resource "google_project_iam_member" "deployer_metrics_viewer" {
  project = local.project_id
  role    = "roles/monitoring.viewer"
  member  = "serviceAccount:${google_service_account.deployer.email}"
}
