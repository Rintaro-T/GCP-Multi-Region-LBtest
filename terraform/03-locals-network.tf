
# これは03-network.tf内のfor_eachで使うためのlocalが格納されています
# また，04-instance-template.tfにおいてもfor_eachでsubnetsのeach.keyのみ使用します．
# これは04-instance-template.tf内においてsubnetworkを呼び出す箇所があり，複数箇所を編集しなおす必要がなくなるため非常に効果的です．

locals {

  #subnetworkのfor_each--------------------------------------

  subnets = {

    # Tokyoのsubnet
    tokyo = {
      ip_cidr_range = "192.168.120.0/24"
      region        = local.region1
    }

    # LasVegasのsubnet
    vegas = {
      ip_cidr_range = "192.168.121.0/24"
      region        = local.region2
    }
  }

  #FWルールのfor_each-----------------------------------------
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

