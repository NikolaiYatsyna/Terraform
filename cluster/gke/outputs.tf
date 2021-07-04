output "host" {
    value = google_container_cluster.primary.endpoint
}

output "cluster_certificate" {
    value = google_container_cluster.primary.master_auth.0.cluster_ca_certificate
}

output "client_key" {
  description = "Private key used by clients to authenticate to the cluster endpoint"
  value       = google_container_cluster.primary.master_auth.0.client_key
}

output "client_certificate" {
  description = "Public certificate used by clients to authenticate to the cluster endpoint"
  value       = google_container_cluster.primary.master_auth.0.client_certificate
}
