resource "google_cloudfunctions_function" "function" {
  project = var.project
  region = var.region
  name        = var.function_name[count.index]
  runtime     = var.runtime
  available_memory_mb   = 256
  count = 6
  trigger_http          = true
  entry_point           = var.entrypoint[count.index]
  service_account_email = var.service_account

  source_repository {
    url = var.source_repository_url[count.index]
  }
}

resource "google_cloudfunctions_function" "function2" {
  project = var.project
  region = var.region
  name        = var.function_name2[count.index]
  runtime     = var.runtime
  available_memory_mb   = 256
  count = 2
  event_trigger {
    event_type = "google.storage.object.finalize"
    resource = "covid-raw-data"
  }
  entry_point           = var.entrypoint2[count.index]
  service_account_email = var.service_account

  source_repository {
    url = var.source_repository_url2[count.index]
  }
}

# IAM entry for all users to invoke the function
resource "google_cloudfunctions_function_iam_member" "invoker" {
  count = 8
  project        = google_cloudfunctions_function.function[count.index].project
  region         = google_cloudfunctions_function.function[count.index].region
  cloud_function = google_cloudfunctions_function.function[count.index].name
  role   = "roles/cloudfunctions.invoker"
  member = "allUsers"
}