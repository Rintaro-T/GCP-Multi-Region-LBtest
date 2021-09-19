#VPCネットワークとサブネットの生成
resource "google_compute_network" "mrlb" {
  project                 = local.project
  name                    = "${var.base_name}-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "mrlb-tokyo" {
  project       = local.project
  name          = "${var.base_name}-sub-tokyo"
  ip_cidr_range = "192.168.120.0/24"
  region        = var.instance_region
  network       = google_compute_network.mrlb.id
}

resource "google_compute_subnetwork" "mrlb-vegas" {
  project       = local.project
  name          = "${var.base_name}-sub-vegas"
  ip_cidr_range = "192.168.121.0/24"
  region        = var.instance_region2
  network       = google_compute_network.mrlb.id
}

#for_eachを用いたhttpファイヤウォールとicmpファイアウォールの生成．
resource "google_compute_firewall" "mrlb-http-fw" {
  for_each = local.fw-rules

  project = local.project
  name    = each.key
  network = google_compute_network.mrlb.name

  allow {
    protocol = each.value.protocol
    ports    = each.value.ports
  }
  target_tags = [each.key]
}

