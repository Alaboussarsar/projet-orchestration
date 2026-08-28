terraform {
  required_version = ">= 1.5"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.30"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "minikube"
}

module "ecs" {
  source = "./modules/ecs"

  aws_region    = var.aws_region
  account_id    = var.account_id
  ecr_repo_name = var.ecr_repo_name
  image_tag     = var.image_tag
  cluster_name  = var.ecs_cluster_name
  desired_count = var.ecs_desired_count
}

module "k8s" {
  source = "./modules/k8s"

  app_image = "nginxdemos/hello:plain-text"
  replicas  = var.k8s_replicas
  namespace = var.k8s_namespace
}