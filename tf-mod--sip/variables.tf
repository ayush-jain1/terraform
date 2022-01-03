variable "project" {
}

variable "region" {
}

variable "environment" {
}

variable "ip_count" {
  description = "number of static ips to request"
  type        = number
  default     = 2
}

variable "naming_prefix" {
  description = "The value to fill this naming scheme: <naming_prefix>-<environment>-sip-<increment>-<region> i.e 'mgmt-nat' = mgmt-nat-prd-sip-01-euwe1"
}

variable "subnetwork" {
  default     = null
  description = "The name of the subnetwork in which to reserve the address"
}

variable "host_project" {
  default     = null
  description = "The name of the host project in which the subnetwork resides"
}