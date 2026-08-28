variable "aws_region" {
  default = "us-east-1"
}

variable "account_id" {
  default = "538752189363"
}

variable "ecr_repo_name" {
  default = "web-ipssi-tf"
}

variable "image_tag" {
  default = "1.0.0"
}

variable "ecs_cluster_name" {
  default = "ipssi-ecs-tf"
}

variable "ecs_desired_count" {
  default = 2
}

variable "k8s_namespace" {
  default = "prod-tf"
}

variable "k8s_replicas" {
  default = 3
}