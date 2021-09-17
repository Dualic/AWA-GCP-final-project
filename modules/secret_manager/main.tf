# resource "google_secret_manager_secret" "dataprep-password" {
#   provider = google-beta
  
#   secret_id = "dataprep-password"
#   replication {
#     automatic = true
#   }
# }

# resource "google_secret_manager_secret_version" "dataprep-password" {
#   secret = google_secret_manager_secret.admin-password.id
#   secret_data = var.password
# }