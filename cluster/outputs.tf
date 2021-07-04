output "host" {
    value = module.kubernetes.host
}

output "cluster_certificate" {
    value = module.kubernetes.cluster_certificate
}

output "client_key" {
    description = "Private key used by clients to authenticate to the cluster endpoint"
    value = module.kubernetes.client_key
}

output "client_certificate" {
    description = "Public certificate used by clients to authenticate to the cluster endpoint"
    value = module.kubernetes.client_certificate
}
