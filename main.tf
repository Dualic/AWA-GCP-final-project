terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "~> 3.5.0"
    }
  }
}

provider "google" {
  project= var.project
  region = var.region
  zone = var.zone
}

provider "google-beta" {
  project = var.project
  region  = var.region
  zone    = var.zone
}

module "storage" {
  source     = ".//modules/storage"
  project = var.project
  region = var.region
}

# module "dialogflow" {
#   source     = ".//modules/dialogflow_agent"
#   project = var.project
#   region = var.region
# }

module "database" {
  source = ".//modules/database"
  project = var.project
  region = var.region
  depends_on = [module.functions,]
}

module "functions" {
  source = ".//modules/functions"
  project = var.project
  region = var.region
  depends_on = [module.storage,]
}

module "workflow" {
  source = ".//modules/workflow"
  region = var.region
  depends_on = [module.functions,]
}

# module "cloud_scheduler" {
#     source = ".//modules/cloud_build"
#     project = var.project
# }

# module "secret_manager" {
#   source = ".//modules/secret_manager"
#   project = var.project
#   password = var.dppassword
# }

terraform {
  backend "gcs" {
    bucket = "backend-bucket-final-project"
  }
}