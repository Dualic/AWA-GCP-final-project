/* resource "google_cloud_scheduler_job" "job" {
  name             = var.scheduler_name
  description      = var.scheduler_description
  schedule         = var.schedule
  time_zone        = var.time_zone
  

  http_target {
    http_method = var.http_method
    uri         = module.functions.function_url #tämä ei välttämättä oikein
  }
} */