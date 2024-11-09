resource "google_compute_global_address" "static_ip" {
  name = "static-site-ip"
}

resource "google_compute_url_map" "url_map" {
  name            = var.load_balancer_name
  default_service = google_compute_backend_service.static_site_backend.self_link
}

resource "google_compute_backend_service" "static_site_backend" {
  name        = "static-site-backend"
  port_name   = "http"
  protocol    = "HTTP"
  timeout_sec = 10
  health_checks = [google_compute_http_health_check.static_site_check.self_link]
}

resource "google_compute_http_health_check" "static_site_check" {
  name               = "static-site-health-check"
  request_path       = "/"
  check_interval_sec = 10
  timeout_sec        = 5
}

resource "google_compute_target_http_proxy" "http_proxy" {
  name    = "static-site-proxy"
  url_map = google_compute_url_map.url_map.self_link
}

resource "google_compute_global_forwarding_rule" "http_rule" {
  name        = "http-forwarding-rule"
  ip_address  = google_compute_global_address.static_ip.address
  port_range  = "80"
  target      = google_compute_target_http_proxy.http_proxy.self_link
}
