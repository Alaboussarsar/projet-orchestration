variable "app_image" {
  type = string
}

variable "replicas" {
  type    = number
  default = 3
}

variable "namespace" {
  type = string
}