terraform {
    required_providers {
        kubernetes = {}
        helm = {}
    }
}
resource "kubernetes_namespace" "tooling-namespace" {
  metadata {
    name = var.namespace
  }
}

module "nginx-ingress" {
    source = "./nginx-ingress"
}

module "consul" {
    source = "./consul"
    namespace  = kubernetes_namespace.tooling-namespace.metadata[0].name
    sub_domain = var.tooling_default_subdomain
}

module "vault" {
    source = "./vault"
    namespace = kubernetes_namespace.tooling-namespace.metadata[0].name
    sub_domain = var.tooling_default_subdomain
}

module "argo-cd" {
    source = "./argo-cd-server"
    namespace = kubernetes_namespace.tooling-namespace.metadata[0].name
    sub_domain = var.tooling_default_subdomain
}

module "harbor" {
    source = "./harbor-registry"
    namespace = kubernetes_namespace.tooling-namespace.metadata[0].name
    sub_domain = var.tooling_default_subdomain
}
