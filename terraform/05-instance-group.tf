#インスタンスグループの生成．インスタンスの自動増減の設定
resource "google_compute_region_instance_group_manager" "mrlb-group" {
  for_each = local.instance_groups

  project     = local.project
  name        = "mrlb-group-${each.key}"
  description = "instance group for ${each.key}"

  base_instance_name        = "mrlb-${each.key}"
  region                    = each.value.region
  distribution_policy_zones = each.value.zones

  version {
    instance_template = google_compute_instance_template.mrlb[each.key].id
  }

}


resource "google_compute_region_autoscaler" "mrlb-autoscaler" {
  for_each = local.instance_groups

  project = local.project
  name    = "mrlb-autoscaler-${each.key}"
  region  = each.value.region
  target  = google_compute_region_instance_group_manager.mrlb-group[each.key].id

  autoscaling_policy {
    max_replicas    = 10
    min_replicas    = 3
    cooldown_period = 60

    cpu_utilization {
      target = 0.4
    }
  }
}
