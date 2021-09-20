#インスタンスグループの生成．インスタンスの自動増減の設定
resource "google_compute_region_instance_group_manager" "mrlb-group-tokyo" {
  project     = local.project
  name        = "mrlb-group-tokyo"
  description = "instance group for tokyo"

  base_instance_name        = "mrlb-tokyo"
  region                    = var.instance_region
  distribution_policy_zones = var.instance_zones

  version {
    instance_template = google_compute_instance_template.mrlb["tokyo"].id
  }

}

resource "google_compute_region_instance_group_manager" "mrlb-group-vegas" {
  project     = local.project
  name        = "mrlb-group-vegas"
  description = "instance group for Vegas"

  base_instance_name        = "mrlb-vegas"
  region                    = var.instance_region2
  distribution_policy_zones = var.instance_zones2

  version {
    instance_template = google_compute_instance_template.mrlb["vegas"].id
  }

}

resource "google_compute_region_autoscaler" "mrlb-autoscaler-tokyo" {
  project = local.project
  name    = "mrlb-autoscaler-tokyo"
  region  = var.instance_region
  target  = google_compute_region_instance_group_manager.mrlb-group-tokyo.id

  autoscaling_policy {
    max_replicas    = 10
    min_replicas    = 3
    cooldown_period = 60

    cpu_utilization {
      target = 0.4
    }
  }
}

resource "google_compute_region_autoscaler" "mrlb-autoscaler-vegas" {
  project = local.project
  name    = "mrlb-autoscaler-vegas"
  region  = var.instance_region2
  target  = google_compute_region_instance_group_manager.mrlb-group-vegas.id

  autoscaling_policy {
    max_replicas    = 10
    min_replicas    = 3
    cooldown_period = 60

    cpu_utilization {
      target = 0.4
    }
  }
}
