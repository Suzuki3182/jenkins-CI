provider "google" {
  project = "jenkins-ci-441120"
  region  = "us-east1"
}

resource "google_storage_bucket" "static_site" {
  name     = "your-static-website-bucket"
  location = "US"
  website {
    main_page_suffix = "index.html"
  }
}

resource "google_storage_bucket_object" "index" {
  name   = "index.html"
  bucket = google_storage_bucket.static_site.name
  source = "gs://your-static-website-bucket/index.html"
  content_type = "text/html"
}

resource "google_compute_backend_bucket" "static_site_backend" {
  name        = "static-site-backend"
  bucket_name = google_storage_bucket.static_site.name
}

resource "google_compute_url_map" "static_site" {
  name            = "static-site"
  default_service = google_compute_backend_bucket.static_site_backend.self_link
}

resource "google_compute_target_http_proxy" "static_site_proxy" {
  name   = "static-site-proxy"
  url_map = google_compute_url_map.static_site.self_link
}

resource "google_compute_global_forwarding_rule" "static_site_rule" {
  name       = "static-site-rule"
  target     = google_compute_target_http_proxy.static_site_proxy.self_link
  port_range = "80"
  ip_address = google_compute_global_address.static_site_ip.address
}