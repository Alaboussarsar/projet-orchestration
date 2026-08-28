output "alb_dns_name" {
  value = aws_lb.web.dns_name
}

output "ecr_repository_url" {
  value = aws_ecr_repository.web.repository_url
}

output "cluster_name" {
  value = aws_ecs_cluster.this.name
}