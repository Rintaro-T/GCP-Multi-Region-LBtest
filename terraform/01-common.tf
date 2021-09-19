
locals {
  #プロジェクト名の指定
  project = "multi-region-lbtest-20210917"


  #FWルールのfor_each
  fw-rules = {

    #httpファイヤウォールの設定
    mrlb-http = {
      protocol = "tcp"
      ports    = ["80"]
    }

    #icmpファイヤウォールの設定
    mrlb-icmp = {
      protocol = "icmp"
      ports    = []
    }
  }

}

