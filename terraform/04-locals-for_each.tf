
# これは04-instance-template.tf内のfor_eachで使うためのlocalが格納されています

locals {

  #instance_templateのfor_each--------------------------------------

  instance_templates = {

    # Tokyoのinstance_template
    tokyo = {
    }

    # LasVegasのinstance_template
    vegas = {
    }
  }

}

