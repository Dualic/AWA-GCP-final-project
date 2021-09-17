/* resource "google_cloud_scheduler_job" "job" {
  name             = "scheduler_job"
  description      = "daily triggering of currency data pipeline functions"
  schedule         = "0 1 * * *"
  time_zone        = "Europe/Helsinki"
  

  http_target {
    http_method = var.http_method
    uri         = module.functions.function_url #tämä ei välttämättä oikein
  }
} */