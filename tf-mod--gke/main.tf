resource "google_container_cluster" "cluster" {
  provider                 = google-beta
  project                  = var.project
  name                     = var.cluster_name
  location                 = var.region
  remove_default_node_pool = true
  initial_node_count       = 1

  logging_service    = "logging.googleapis.com/kubernetes"
  monitoring_service = "monitoring.googleapis.com/kubernetes"

  network    = google_compute_network.network.self_link
  subnetwork = google_compute_subnetwork.subnet.self_link
  enable_shielded_nodes = true
  workload_identity_config {
    identity_namespace = "ide-ccoe.svc.id.goog"
  }

  network_policy {
    enabled = true
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = google_compute_subnetwork.subnet.secondary_ip_range.0.range_name
    services_secondary_range_name = google_compute_subnetwork.subnet.secondary_ip_range.1.range_name
  }

  master_authorized_networks_config {
    cidr_blocks {
      display_name = "cloudshell"
      cidr_block   = "35.197.153.80/32"
    }
    cidr_blocks {
      display_name = "ayush-mac"
      cidr_block   = "49.37.167.203/32"
    }
  }

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
    master_ipv4_cidr_block  = "172.16.0.16/28"
  }
  master_auth {
    username = ""
    password = ""
    client_certificate_config {
      issue_client_certificate = false
    }
  }

  cluster_autoscaling {
    enabled = true
    resource_limits {
      resource_type = "cpu"
      minimum       = 1
      maximum       = 4
    }
    resource_limits {
      resource_type = "memory"
      minimum       = 4
      maximum       = 16
    }
  }

  addons_config {
    // Enable network policy (Calico)
    network_policy_config {
      disabled = false
    }
  }

  timeouts {
    create = "30m"
    update = "30m"
    delete = "30m"
  }

  node_config {
    shielded_instance_config {
      enable_secure_boot          = true
      enable_integrity_monitoring = true
    }
  }

  depends_on = [
    google_compute_router_nat.nat
  ]
}


resource "google_container_node_pool" "private_np1" {
  provider = google-beta
  project  = var.project
  name     = var.cluster_name
  location = var.region

  cluster            = google_container_cluster.cluster.name
  initial_node_count = 1

  autoscaling {
    min_node_count = "3"
    max_node_count = "3"
  }
  node_config {
    disk_size_gb = 30
    disk_type    = "pd-standard"
    image_type   = "COS"
    preemptible  = true
    machine_type = var.machine_type

    shielded_instance_config {
      enable_secure_boot          = true
      enable_integrity_monitoring = true
    }

    workload_metadata_config {
      node_metadata = "GKE_METADATA_SERVER"
    }

    #service_account = google_service_account.gke-sa.email
    // Use the minimal oauth scopes needed
    oauth_scopes = [
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/trace.append",
    ]
  }

  depends_on = [
    google_container_cluster.cluster
  ]

}