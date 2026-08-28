resource "kubernetes_namespace" "this" {
  metadata {
    name = var.namespace
  }
}

resource "kubernetes_config_map" "web" {
  metadata {
    name      = "web-config"
    namespace = kubernetes_namespace.this.metadata[0].name
  }

  data = {
    APP_ENV   = "production"
    APP_TITRE = "IPSSI - Mastere Cyber"
  }
}

resource "kubernetes_deployment" "web" {
  metadata {
    name      = "web"
    namespace = kubernetes_namespace.this.metadata[0].name
  }

  spec {
    replicas = var.replicas

    selector {
      match_labels = { app = "web" }
    }

    strategy {
      type = "RollingUpdate"
      rolling_update {
        max_surge       = "1"
        max_unavailable = "0"
      }
    }

    template {
      metadata {
        labels = { app = "web" }
      }

      spec {
        container {
          name  = "web"
          image = var.app_image

          port {
            container_port = 80
          }

          env_from {
            config_map_ref {
              name = kubernetes_config_map.web.metadata[0].name
            }
          }

          readiness_probe {
            http_get {
              path = "/"
              port = 80
            }
            initial_delay_seconds = 3
          }

          liveness_probe {
            http_get {
              path = "/"
              port = 80
            }
            initial_delay_seconds = 5
            period_seconds        = 10
          }

          resources {
            requests = {
              cpu    = "50m"
              memory = "32Mi"
            }
            limits = {
              cpu    = "150m"
              memory = "64Mi"
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "web" {
  metadata {
    name      = "web-svc"
    namespace = kubernetes_namespace.this.metadata[0].name
  }

  spec {
    selector = { app = "web" }

    port {
      port        = 80
      target_port = 80
    }
  }
}

resource "kubernetes_ingress_v1" "web" {
  metadata {
    name      = "web-ingress"
    namespace = kubernetes_namespace.this.metadata[0].name
  }

  spec {
    rule {
      host = "web-tf.ipssi.local"
      http {
        path {
          path      = "/"
          path_type = "Prefix"
          backend {
            service {
              name = kubernetes_service.web.metadata[0].name
              port {
                number = 80
              }
            }
          }
        }
      }
    }
  }
}