output "namespace" {
  value = kubernetes_namespace.this.metadata[0].name
}

output "ingress_host" {
  value = "web-tf.ipssi.local"
}