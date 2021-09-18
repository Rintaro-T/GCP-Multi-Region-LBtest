#バックエンドのためのヘルスチェック
resource "google_compute_health_check" "mrlb-backend-healthcheck" {
  project = local.project
  name    = "mrlb-backend-healthcheck"

  timeout_sec         = 5
  check_interval_sec  = 5
  healthy_threshold   = 2
  unhealthy_threshold = 2

  http_health_check {
    port = 80
  }
}

#バックエンド
resource "google_compute_backend_service" "mrlb-backend" {
  project = local.project
  name    = "mrlb-backend"

  protocol    = "HTTP"
  timeout_sec = 30

  health_checks = [google_compute_health_check.mrlb-backend-healthcheck.id]

  backend {
    group           = google_compute_region_instance_group_manager.mrlb-group-tokyo.instance_group
    balancing_mode  = "UTILIZATION"
    capacity_scaler = 0.8
  }

  backend {
    group           = google_compute_region_instance_group_manager.mrlb-group-vegas.instance_group
    balancing_mode  = "UTILIZATION"
    capacity_scaler = 0.8
  }
}

