#サービスアカウントの発行
resource "google_service_account" "mrlb" {
  project      = local.project
  account_id   = "${var.sa_name}-terraform"
  display_name = "${var.sa_name}-terraform"
}

