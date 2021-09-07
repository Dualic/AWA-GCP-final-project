terraform {
  backend "gcs" {
    bucket  = var.backend_bucket
    prefix  = "terraform/state"
    depends_on = [google_storage_bucket.bucket[1],]
  }

  required_providers {
    google = {
      source = "hashicorp/google"
      version = "~> 3.45.0"
    }
  }
}

provider "google" {
  credentials = file(var.credentials_file)
}

module "storage" {
  source     = ".//modules/storage"
  project_id = var.project_id
  region = var.region
}

module "database" {
  source = ".//modules/database"
  project_id = var.project_id
  region = var.region
}

module "functions" {
  source = ".//modules/functions"
  project_id = var.project_id
  region = var.region
}

module "data_fusion" {
  source = ".//modules/data_fusion"
  project_id = var.project_id
  region = var.region
}

module "cloud_build" {
  source = ".//modules/cloud_build"
  project_id = var.project_id
  region = var.region
}

module "cloud_scheduler" {
    source = ".//modules/cloud_build"
    project_id = var.project_id
}