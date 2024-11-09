terraform {
  required_version = ">= 1.0.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.0.0"
    }
  }
}

provider "google" {
  credentials = "/home/suzuki/Documents/jenkins-ci-441120-ebbb99759f7c.json"
  project     = var.project_id
  region      = var.region
}
