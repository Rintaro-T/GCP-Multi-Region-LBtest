#Packerにより生成したnginxとコンテンツの入ったイメージからテンプレートイメージを作る
resource "google_compute_instance_template" "mrlb" {
  for_each = local.instance_templates

  project     = local.project
  name        = "mrlb-nginx-template-${each.key}"
  description = "nginx server for ${each.key}"

  machine_type   = var.instance_type
  can_ip_forward = false

  tags = ["mrlb-http", "mrlb-icmp"]

  disk {
    source_image = "csnginx-${each.key}"
    auto_delete  = true
    boot         = true
  }
  network_interface {
    network    = google_compute_network.mrlb.id
    subnetwork = google_compute_subnetwork.mrlb[each.key].id
  }
  service_account {
    email  = google_service_account.mrlb.email
    scopes = ["cloud-platform"]
  }

}

