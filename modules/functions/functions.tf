resource "google_cloudfunctions_function" "function" {
  project = var.project
  region = var.region
  name        = var.function_name[count.index]
  runtime     = var.runtime
  available_memory_mb   = 256
  count = 5
  trigger_http          = true
  entry_point           = var.entrypoint[count.index]
  service_account_email = "https://console.cloud.google.com/iam-admin/serviceaccounts/project?project=leo-test-env-1"

  source_repository {
    url = var.source_repository_url[count.index]
  }
}

# IAM entry for all users to invoke the function
resource "google_cloudfunctions_function_iam_member" "invoker" {
  count = 5
  project        = google_cloudfunctions_function.function[count.index].project
  region         = google_cloudfunctions_function.function[count.index].region
  cloud_function = google_cloudfunctions_function.function[count.index].name
  role   = "roles/cloudfunctions.invoker"
  member = "allUsers"
}