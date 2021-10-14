module "tf-mod--gke" {
  source       = "../../../"
  project      = var.project
  region       = var.region
  zone         = var.zone
  cluster_name = var.cluster_name
  machine_type = var.machine_type
}