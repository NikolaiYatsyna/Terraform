locals {
  app_name             = "argo-cd"
  host                 = "${local.app_name}.${var.sub_domain}"
  argo_ui_service_port = "http"
}

resource "helm_release" "argo-cd-helm-release" {
  atomic     = true
  chart      = "argo-cd"
  repository = "https://argoproj.github.io/argo-helm"
  name       = local.app_name
  namespace  = var.namespace
  values = [templatefile("${path.module}/config.tpl", {
    name_override   = local.app_name
    argo_cd_version = var.argo_cd_version
    extra_args      = var.extra_args
    dex_enabled     = var.dex_enabled
    install_crd     = var.install_crd
    extra_args      = var.extra_args
  })]
}

resource "kubernetes_ingress" "argo-cd-ingress" {
  wait_for_load_balancer = true
  metadata {
    name        = "${local.app_name}-http-ingress"
    namespace   = var.namespace
    annotations = {
        "kubernetes.io/ingress.class" = "nginx"
        "nginx.ingress.kubernetes.io/force-ssl-redirect" : "true"
        "nginx.ingress.kubernetes.io/backend-protocol" : "HTTP"
    }
  }
  spec {
    backend {
      service_name = local.app_name
      service_port = local.argo_ui_service_port
    }
    rule {
      host = local.host
      http {
        path {
          path = "/*"
          backend {
            service_name = local.app_name
            service_port = local.argo_ui_service_port
          }
        }
      }
    }
    tls {
      hosts = [local.host]
    }
  }
}
