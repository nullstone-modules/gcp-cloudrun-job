output "image_repo_url" {
  value       = local.repository_url
  description = "string ||| Service container image url."
}

output "project_id" {
  value       = local.project_id
  description = "string ||| The GCP Project ID hosting this Cloud Run Job"
}

output "log_provider" {
  value       = "cloudlogging"
  description = "string ||| The log provider used for this service."
}

output "log_filter" {
  value       = "resource.type=\"cloud_run_job\" AND resource.labels.service_name=\"${local.job_name}\""
  description = "string ||| A log filter used by "
}

output "service_name" {
  value       = "" // Always blank because we don't create a Service for jobs
  description = "string ||| This is blank because we don't have a Service for jobs."
}

output "job_id" {
  value       = google_cloud_run_v2_job.this.id
  description = "string ||| The ID of the Cloud Run job. (projects/{project_id}/locations/{location}/jobs/{job_name})"
}

output "job_name" {
  value       = google_cloud_run_v2_job.this.name
  description = "string ||| The name of the Cloud Run job."
}

output "image_pusher" {
  value = {
    email       = try(google_service_account.image_pusher.email, "")
    impersonate = true
  }

  description = "object({ email: string, impersonate: bool }) ||| A GCP service account that is allowed to push images."

  sensitive = true
}

output "deployer" {
  value = {
    email       = try(google_service_account.deployer.email, "")
    impersonate = true
  }

  description = "object({ email: string, impersonate: bool }) ||| A GCP service account with explicit privilege to deploy this Cloud Run job."
  sensitive   = true
}

output "main_container_name" {
  value       = local.main_container_name
  description = "string ||| The name of the container definition for the primary container"
}

output "private_urls" {
  value       = local.private_urls
  description = "list(string) ||| A list of URLs only accessible inside the network"
}

output "public_urls" {
  value       = local.public_urls
  description = "list(string) ||| A list of URLs accessible to the public"
}
