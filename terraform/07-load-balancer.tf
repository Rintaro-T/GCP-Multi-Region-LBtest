#グローバル固定IPの発行
resource "google_compute_global_address" "mrlb-address" {
  project = local.project
  name    = "mrlb-address"
}

#単純なホストとパスのルール
resource "google_compute_url_map" "mrlb-path" {
  project         = local.project
  name            = "mrlb-path"
  default_service = google_compute_backend_service.mrlb-backend.id
}

resource "google_compute_target_http_proxy" "frontend-proxy" {
  project = local.project
  name    = "frontend-proxy"
  url_map = google_compute_url_map.mrlb-path.id
}

resource "google_compute_global_forwarding_rule" "glblfwd" {
  project     = local.project
  name        = "global-fwd"
  ip_protocol = "TCP"
  target      = google_compute_target_http_proxy.frontend-proxy.id
  port_range  = "80"

  ip_address = google_compute_global_address.mrlb-address.id
}

