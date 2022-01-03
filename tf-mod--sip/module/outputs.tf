
output "sips" {
  value = values(google_compute_address.static_ip)[*].address
}
