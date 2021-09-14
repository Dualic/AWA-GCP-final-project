variable "runtime" {
  type = string
  default = "python37"
}

variable "entrypoint" {
  type = list(string)
  default = ["upload_to_bq","currency_history", "delete_blob", "currency_today", "currenttohistory", "history", "dataprep_job_gcs_trigger", "dataprep_job_gcs_trigger"]
}

variable "source_repository_url" {
  type = list(string)
  default = ["https://source.developers.google.com/projects/leo-test-env-1/repos/github_leonbay_testi-ranch/moveable-aliases/master/paths/functions/bq-data-transfer",
             "https://source.developers.google.com/projects/leo-test-env-1/repos/github_leonbay_testi-ranch/moveable-aliases/master/paths/functions/currencyhistory",
             "https://source.developers.google.com/projects/leo-test-env-1/repos/github_leonbay_testi-ranch/moveable-aliases/master/paths/functions/delete-func",
             "https://source.developers.google.com/projects/leo-test-env-1/repos/github_leonbay_testi-ranch/moveable-aliases/master/paths/functions/todayscurrencies",
             "https://source.developers.google.com/projects/leo-test-env-1/repos/github_leonbay_testi-ranch/moveable-aliases/master/paths/functions/daily-to-history",
             "https://source.developers.google.com/projects/leo-test-env-1/repos/github_leonbay_testi-ranch/moveable-aliases/master/paths/functions/currency-history-to-csv",
             "https://source.developers.google.com/projects/leo-test-env-1/repos/github_leonbay_testi-ranch/moveable-aliases/master/paths/functions/CovidHistoryDatatoBigQueryTriggerFunction",
             "https://source.developers.google.com/projects/leo-test-env-1/repos/github_leonbay_testi-ranch/moveable-aliases/master/paths/functions/LatestCovidDatatoBigQueryTriggerFunction"]
}

variable "function_name" {
  type = list(string)
  default = ["bq-data-transfer", "currencyhistory", "delete-func", "todayscurrencies", "daily-to-history", "currency-history-to-csv", "CovidHistoryDatatoBigQueryTriggerFunction", "LatestCovidDatatoBigQueryTriggerFunction"]
}

variable "project" {}

variable "region" {}

variable "service_account" {
  default = "loppuprojekti-325208@appspot.gserviceaccount.com"
  #ei varmuutta onko oikein
  }