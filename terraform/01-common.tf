
locals {
  #プロジェクト名の指定
  project = "multi-region-lbtest-20210917"

  # Region variableのregionとzonesを手軽に変えられるようにするため．
  region1 = "asia-northeast1"
  region2 = "us-west4"

  # Region毎のIPアドレス範囲
  ip_region1 = "192.168.120.0/24"
  ip_region2 = "192.168.121.0/24"

}

#projectもterraformで管理するためにはコメントアウトを外す．
#resource "google_project" "multi-region-lbtest-20210917" {
#  name = "Multi-Region-LBtest"
#  project_id = local.project
#}
