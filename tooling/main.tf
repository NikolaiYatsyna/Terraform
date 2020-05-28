data "google_container_registry_repository" "registry" {
    project = var.project
    region = var.gcr_region
}

module "tooling_cluster" {
    source = "../cluster"

    credentials = var.credentials
    project = var.project
    cluster_name = var.cluster_name
    master_username = var.master_username
    master_password = var.master_password
}

module "jenkins" {
    source = "jenkins"
    gke_host = module.tooling_cluster.gke_host
    gke_cluster_cert = base64decode(module.tooling_cluster.gke_cluster_cert)
    master_username = module.tooling_cluster.master_username
    master_password = module.tooling_cluster.master_password
}
