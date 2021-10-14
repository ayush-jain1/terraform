########################################
## Create Network #################
########################################
resource "google_compute_network" "network" {
  project                 = var.project
  name                    = format("%s-network", var.cluster_name)
  auto_create_subnetworks = false
}

########################################
## Create Sub Network #################
########################################
resource "google_compute_subnetwork" "subnet" {
  project                  = var.project
  name                     = format("%s-subnet", var.cluster_name)
  network                  = google_compute_network.network.self_link
  region                   = var.region
  private_ip_google_access = true
  ip_cidr_range            = "10.0.0.0/24"

  secondary_ip_range {
    range_name    = format("%s-pod-range", var.cluster_name)
    ip_cidr_range = "10.1.0.0/16"
  }

  secondary_ip_range {
    range_name    = format("%s-svc-range", var.cluster_name)
    ip_cidr_range = "10.2.0.0/20"
  }
}

########################################
## Create Cloud Router #################
########################################
resource "google_compute_router" "router" {
  project = var.project
  name    = format("%s-cloud-router", var.cluster_name)
  network = google_compute_network.network.self_link
  region  = var.region
  bgp {
    asn = 64515
  }
}

########################################
## Create Cloud NAT #################
########################################
resource "google_compute_router_nat" "nat" {
  project                            = var.project
  name                               = format("%s-cloud-nat", var.cluster_name)
  router                             = google_compute_router.router.name
  region                             = var.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}