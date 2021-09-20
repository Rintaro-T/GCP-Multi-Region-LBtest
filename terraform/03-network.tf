#VPCネットワークとサブネットの生成
resource "google_compute_network" "mrlb" {
  project                 = local.project
  name                    = "${var.base_name}-network"
  auto_create_subnetworks = false
}

# for_eachを用いたsubnetworkの生成
resource "google_compute_subnetwork" "mrlb" {
  for_each = local.subnets

  project       = local.project
  name          = "${var.base_name}-${each.key}"
  ip_cidr_range = each.value.ip_cidr_range
  region        = each.value.region
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

