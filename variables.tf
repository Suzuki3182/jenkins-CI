variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The region to deploy resources"
  type        = string
  default     = "us-central1"
}

variable "bucket_name" {
  description = "The name of the GCS bucket for static content"
  type        = string
}

variable "load_balancer_name" {
  description = "The name of the HTTP load balancer"
  type        = string
}