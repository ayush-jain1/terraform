// Required values to be set in terraform.tfvars
variable "project" {
  description = "The project in which to hold the components"
  type        = string
}

variable "region" {
  description = "The region in which to create the VPC network"
  type        = string
}

variable "zone" {
  description = "The zone in which to create the Kubernetes cluster. Must match the region"
  type        = string
}

variable "cluster_name" {
  description = "The name of the gke cluster"
  type        = string
}

variable "machine_type" {
  description = "The machine type  of the gke nodes"
  type        = string
}
