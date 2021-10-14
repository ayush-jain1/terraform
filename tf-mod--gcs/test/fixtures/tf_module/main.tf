module "tf-mod--gcs" {
  source        = "../../../"
  project       = var.project
  name          = var.name
  location      = var.location
  storage_calss = var.storage_class

}