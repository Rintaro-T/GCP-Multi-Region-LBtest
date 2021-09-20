
# これは03-network.tf内のfor_eachで使うためのlocalが格納されています

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

