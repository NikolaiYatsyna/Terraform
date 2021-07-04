resource "helm_release" "ingress-nginx-helm-release" {
  name       = "ingress-nginx"
  chart      = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  values = [templatefile("${path.module}/config.tpl", {
    logLevel = 5
  })]
}
