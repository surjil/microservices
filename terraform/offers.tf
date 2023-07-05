resource "kubernetes_namespace" "offer" {
  metadata {
    name = "mss"
  }
}
resource "kubernetes_deployment" "offer" {
  metadata {
    name      = "offer"
    namespace = "mss"
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "offer"
      }
    }
    template {
      metadata {
        labels = {
          app = "offer"
        }
      }
      spec {
        container {
          image = "surjil1612/spring:v1"
          name  = "offer"
          port {
            container_port = 1001
          }
        }
      }
    }
  }
}
resource "kubernetes_service" "offer" {
  metadata {
    name      = "offer"
    namespace = "mss"
  }
  spec {
    selector = {
      app = kubernetes_deployment.offer.spec.0.template.0.metadata.0.labels.app
    }
    type = "ClusterIP"
    port {
      port        = 1001
      target_port = 1001
    }
  }
}
