terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

provider "google" {
  credentials = file("/Users/ayujain5/Downloads/ide-ccoe-6c34e13dfa8e.json")
  project = var.project
  region  = var.region
  zone    = var.zone
}

provider "google-beta" {
  credentials = file("/Users/ayujain5/Downloads/ide-ccoe-6c34e13dfa8e.json")
  project = var.project
  region  = var.region
  zone    = var.zone
}