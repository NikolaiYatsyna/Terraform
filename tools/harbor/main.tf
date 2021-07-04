locals {
  app_name   = "harbor"
  host       = "${local.app_name}.${var.sub_domain}"
}

resource "helm_release" "harbor-helm-release" {
  chart      = "harbor"
  repository = "https://helm.goharbor.io"
  name       = local.app_name
  namespace  = var.namespace
  values = [templatefile("${path.module}/config.tpl", {
    host = local.host
  })]
}
