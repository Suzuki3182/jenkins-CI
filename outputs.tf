output "website_url" {
  value       = "http://${google_compute_global_address.static_site_ip.address}"
  description = "URL to access the static website"
}
