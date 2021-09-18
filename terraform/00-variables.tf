
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
variable "instance_zone" {
  type    = string
  default = "asia-northeast1-b"
}

variable "instance_zone2" {
  type    = string
  default = "asia-northeast1-a"
}

variable "instance_zone3" {
  type    = string
  default = "asia-northeast1-c"
}

variable "instance_zone4" {
  type    = string
  default = "us-west4-b"
}

variable "instance_zone5" {
  type    = string
  default = "us-west4-a"
}

variable "instance_zone6" {
  type    = string
  default = "us-west4-c"
}

variable "sa_name" {
  type    = string
  default = "nixie"
}


