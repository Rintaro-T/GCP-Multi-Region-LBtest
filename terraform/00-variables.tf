
variable "base_name" {
  type    = string
  default = "mrlb"
}

variable "instance_type" {
  type    = string
  default = "f1-micro"
}

#regon-----------------------------------------------------
variable "instance_region" {
  type    = string
  default = "asia-northeast1"
}

variable "instance_region2" {
  type    = string
  default = "us-west4"
}

#region1 zones---------------------------------------------
variable "instance_zones" {
  type    = list(string)
  default = ["asia-northeast1-a", "asia-northeast1-b", "asia-northeast1-c"]
}

variable "instance_zones2" {
  type    = list(string)
  default = ["us-west4-a", "us-west4-b", "us-west4-c"]
}

#Service Account ------------------------------------------
variable "sa_name" {
  type    = string
  default = "mrlb-vm"
}

#Instance Group Auto Scalerの閾値のCPU使用率
variable "cpu_utilization_target" {
  type    = number
  default = 0.4
}
