module "sip" {
  source        = "./module"
  project       = var.project
  region        = var.region
  ip_count      = var.ip_count
  naming_prefix = var.naming_prefix
  subnetwork    = var.subnetwork
  host_project  = var.host_project
  environment   = var.environment
}