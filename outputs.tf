output "ecs_alb_dns_name" {
  value = module.ecs.alb_dns_name
}

output "ecs_ecr_repository_url" {
  value = module.ecs.ecr_repository_url
}

output "k8s_namespace" {
  value = module.k8s.namespace
}

output "k8s_ingress_host" {
  value = module.k8s.ingress_host
}