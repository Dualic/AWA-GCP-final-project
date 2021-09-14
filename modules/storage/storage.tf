resource "google_storage_bucket" "bucket" {
  name          = var.name[count.index]
  storage_class = "MULTI_REGIONAL"
  force_destroy = true
  project = var.project
  count = 3
}