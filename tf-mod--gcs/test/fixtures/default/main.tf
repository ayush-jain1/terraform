module "tf-mod--gcs" {
  source       = "../../../"
  project       = var.project
  name          = var.name
  location      = var.location
  storage_class = var.storage_class
}