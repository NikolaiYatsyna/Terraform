locals {
  app_name   = "vault"
  host       = "${local.app_name}.${var.sub_domain}"
  chart_repo = "https://helm.releases.hashicorp.com"
  chart_name = "vault"
}

resource "helm_release" "vault" {
  repository = local.chart_repo
  chart      = local.chart_name
  name       = local.app_name
  namespace  = var.namespace
  values = [templatefile("${path.module}/config.tpl", {
    name            = local.app_name
    server_replicas = var.replicas
    host            = local.host
  })]
}
