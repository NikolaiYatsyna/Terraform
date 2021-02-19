resource "google_container_cluster" "primary" {
    name = var.cluster_name
    location = var.region
    master_auth {
        username = var.master_username
        password = var.master_password
        client_certificate_config {
            issue_client_certificate = false
        }
    }
    node_pool {
        node_count = var.node_count
        name = "${var.cluster_name}-node-pool"
        node_config {
            preemptible = true
            machine_type = var.machine_type
            metadata = {
                disable-legacy-endpoints = true
            }
            oauth_scopes = [
                "https://www.googleapis.com/auth/logging.write",
                "https://www.googleapis.com/auth/monitoring",
                "https://www.googleapis.com/auth/devstorage.read_write",
                "https://www.googleapis.com/auth/cloudkms",
                "https://www.googleapis.com/auth/cloud-platform"
            ]
        }
    }
}
