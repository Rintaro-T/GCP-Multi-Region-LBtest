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

#httpファイヤウォールの生成．
resource "google_compute_firewall" "mrlb-fw" {
  project = local.project
  name    = "mrlb-http"
  network = google_compute_network.mrlb.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

}

