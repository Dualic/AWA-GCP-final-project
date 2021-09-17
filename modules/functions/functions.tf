resource "google_cloudfunctions_function" "function" {
  project = var.project
  region = var.region
  name        = var.function_name[count.index]
  runtime     = var.runtime
  available_memory_mb   = 256
  count = 7
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
    resource = "covid-raw-data-test"
  }
  entry_point           = var.entrypoint2[count.index]
  service_account_email = var.service_account

  source_repository {
    url = var.source_repository_url2[count.index]
  }
}

resource "google_cloudfunctions_function" "function3" {
  project = var.project
  region = var.region
  name        = "currency-history-to-csv"
  runtime     = var.runtime
  available_memory_mb   = 256
  event_trigger {
    event_type = "google.storage.object.finalize"
    resource = "currency-raw-data-json"
    #vaihda test pois sitten vikaan versioon
  }
  entry_point           = "history"
  service_account_email = var.service_account

  source_repository {
    url = "https://source.developers.google.com/projects/loppuprojekti-325208/repos/github_leonbay_testi-ranch/moveable-aliases/master/paths/functions/currency-history-to-csv"
  }
}

# IAM entry for all users to invoke the function
resource "google_cloudfunctions_function_iam_member" "invoker" {
  count = 7
  project        = var.project
  region         = var.region
  cloud_function = google_cloudfunctions_function.function[count.index].name
  role   = "roles/cloudfunctions.invoker"
  member = "allUsers"
}

resource "google_cloudfunctions_function_iam_member" "invoker2" {
  count = 2
  project        = var.project
  region         = var.region
  cloud_function = google_cloudfunctions_function.function2[count.index].name
  role   = "roles/cloudfunctions.invoker"
  member = "allUsers"
}

resource "google_cloudfunctions_function_iam_member" "invoker3" {
  project        = var.project
  region         = var.region
  cloud_function = google_cloudfunctions_function.function3.name
  role   = "roles/cloudfunctions.invoker"
  member = "allUsers"
}