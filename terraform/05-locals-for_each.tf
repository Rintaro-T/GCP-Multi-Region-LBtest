
# これは05-instance-group.tf内のfor_eachで使うためのlocalが格納されています

locals {

  #instance_groupのfor_each--------------------------------------

  instance_groups = {

    # Tokyoのinstance_group
    tokyo = {
      region = local.region1
      zones  = ["${local.region1}-a", "${local.region1}-b", "${local.region1}-c"]
    }

    # LasVegasのinstance_group
    vegas = {
      region = local.region2
      zones  = ["${local.region2}-a", "${local.region2}-b", "${local.region2}-c"]
    }
  }

}

