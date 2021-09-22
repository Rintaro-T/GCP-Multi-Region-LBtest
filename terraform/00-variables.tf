#base_name ------------------------------------------------
variable "base_name" {
  type    = string
  default = "mrlb"
}

#instance_type ------------------------------------------
variable "instance_type" {
  type    = string
  default = "f1-micro"
}

#Service Account ------------------------------------------
variable "sa_name" {
  type    = string
  default = "mrlb-vm"
}

#Instance Group Auto Scalerの閾値のCPU使用率---------------
variable "cpu_utilization_target" {
  type    = number
  default = 0.4
}
