locals {
  app_name               = "consul"
  host                   = "${local.app_name}.${var.sub_domain}"
  datacenter = "default"
}

resource "helm_release" "consul-server" {
  atomic     = true
  chart      = "consul"
  repository = "https://helm.releases.hashicorp.com"
  name       = local.app_name
  namespace = var.namespace

  values = [templatefile("${path.module}/config.tpl", {
    name                 = local.app_name
    datacenter_name      = local.datacenter
    server_replicas      = var.server_replicas
    bootstrap_expect     = var.bootstrap_expect
    catalog_sync_enabled = var.catalog_sync_enabled
    catalog_sync_default = var.catalog_sync_default
    host                 = local.host
  })]
}
