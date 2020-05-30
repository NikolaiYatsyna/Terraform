provider "helm" {
    kubernetes {
        host = var.cluster_host
        username = var.cluster_username
        password = var.cluster_password
        cluster_ca_certificate = var.cluster_ca_certificate
    }
}

data "template_file" "consul" {
    template = file("./tooling/consul/config.tpl")
    vars = {
        datacenter_name = var.datacenter_name
        server_replicas = var.server_replicas
        bootstrap_expect = var.bootstrap_expect
        catalog_sync_enabled = var.catalog_sync_enabled
        catalog_sync_default = var.catalog_sync_default
    }
}

resource "helm_release" "consul-server" {
    repository = "https://helm.releases.hashicorp.com"
    chart = "consul"
    name = "tooling"
    values = [ data.template_file.consul.rendered]
}
