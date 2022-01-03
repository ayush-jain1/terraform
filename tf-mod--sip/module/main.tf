locals {
  region_data = split("-", var.region)
  // e.g. euwe1
  region_suffix = "${substr(local.region_data[0], 0, 2)}${substr(local.region_data[1], 0, 2)}${substr(strrev(local.region_data[1]), 0, 1)}"
  // e.g. [01, 02, 03, 04]
  count_list  = [for v in range(1, var.ip_count + 1) : v < 10 ? format("0%d", v) : v]
  sip_project = var.host_project == null ? var.project : var.host_project
}

resource "google_compute_address" "static_ip" {
  for_each     = toset(local.count_list)
  name         = "${var.naming_prefix}-${var.environment}-sip-${each.value}-${local.region_suffix}"
  project      = var.project
  region       = var.region
  subnetwork   = var.subnetwork == null ? null : "projects/${local.sip_project}/regions/${var.region}/subnetworks/${var.subnetwork}"
  address_type = var.subnetwork == null ? "EXTERNAL" : "INTERNAL"
}
/*
output "static_ips" {
  value = values(google_compute_address.static_ip)[*].address
}
*/