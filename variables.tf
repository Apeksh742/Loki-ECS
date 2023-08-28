variable "service_count" {
  type = number
  default = 1
}

variable "service_name" {
  type    = string
  default = "loki"
}

variable "container_image" {
  type    = string
  default = "g"
}


variable "container_port" {
  type    = number
  default = 3100
}

variable "load_balancer_name" {
  type    = string
  default = "APM-services"
}

variable "load_balancer_sg_name" {
  type    = string
  default = "APM Load balancer SG"
}

variable "region" {
  default = "us-east-1"
}