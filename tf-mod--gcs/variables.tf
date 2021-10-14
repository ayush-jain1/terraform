// Required values to be set in terraform.tfvars
variable "project" {
  description = "The project in which to hold the components"
  type        = string
}

variable "name" {
  description = "The name of the bucket"
  type        = string
}

variable "location" {
  description = "The location of gcs bucket"
  type        = string
}

variable "storage_class" {
  description = "The storage class of gcs bucket"
  type        = string
}