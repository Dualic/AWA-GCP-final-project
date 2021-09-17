variable "name" {
  type        = list(string)
  default     = ["currency-archive", "currency-raw-data-json", "currency_csv_bucket", "covid-archive", "covid-raw-data"]
}

variable "region" {}

variable "project" {}


