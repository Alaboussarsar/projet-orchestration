variable "aws_region" {
  type = string
}

variable "account_id" {
  type = string
}

variable "ecr_repo_name" {
  type = string
}

variable "image_tag" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "desired_count" {
  type    = number
  default = 2
}