resource "google_storage_bucket" "bucket" {

  project       = var.project
  name          = var.name
  location      = var.location
  storage_class = var.storage_class
}
