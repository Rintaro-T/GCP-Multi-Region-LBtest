#Packerにより生成したnginxとコンテンツの入ったイメージからテンプレートイメージを作る
resource "google_compute_instance_template" "mrlb-tokyo" {
  project     = local.project
  name        = "mrlb-nginx-template-tokyo"
  description = "nginx server for Tokyo"

  machine_type   = var.instance_type
  can_ip_forward = false

  tags = ["mrlb-http"]

  disk {
    source_image = "csnginx-tokyo"
    auto_delete  = true
    boot         = true
  }
  network_interface {
    network    = google_compute_network.mrlb.id
    subnetwork = google_compute_subnetwork.mrlb-tokyo.id
  }
  service_account {
    email  = google_service_account.mrlb.email
    scopes = ["cloud-platform"]
  }

}

#Packerにより生成したnginxとコンテンツの入ったイメージからVegas用テンプレートイメージを作る
resource "google_compute_instance_template" "mrlb-vegas" {
  project     = local.project
  name        = "mrlb-nginx-template-vegas"
  description = "This template is used to nginx"

  machine_type   = var.instance_type
  can_ip_forward = false

  tags = ["mrlb-http"]

  disk {
    source_image = "csnginx-vegas"
    auto_delete  = true
    boot         = true
  }
  network_interface {
    network    = google_compute_network.mrlb.id
    subnetwork = google_compute_subnetwork.mrlb-vegas.id
  }
  service_account {
    email  = google_service_account.mrlb.email
    scopes = ["cloud-platform"]
  }

}

