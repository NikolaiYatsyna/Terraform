module "kubernetes_cluster" {
  source        = "./cluster"
}

provider "kubernetes" {
  alias                  = "kubernetes"
  host                   = module.kubernetes_cluster.host
  cluster_ca_certificate = base64decode(module.kubernetes_cluster.cluster_certificate)
  client_certificate     = base64decode(module.kubernetes_cluster.client_certificate)
  client_key             = base64decode(module.kubernetes_cluster.client_key)
}

provider "helm" {
  alias = "helm"
  kubernetes {
    host                   = module.kubernetes_cluster.host
    cluster_ca_certificate = base64decode(module.kubernetes_cluster.cluster_certificate)
    client_certificate     = base64decode(module.kubernetes_cluster.client_certificate)
    client_key             = base64decode(module.kubernetes_cluster.client_key)
  }
}

module "tools" {
  source = "./tools"

  providers = {
    kubernetes = kubernetes.kubernetes
    helm       = helm.helm
  }
  namespace                 = "tooling"
  tooling_default_subdomain = var.tooling_subdomain
}
