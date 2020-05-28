data "google_container_registry_repository" "registry" {
    project = var.project
    region = var.gcr_region
}

module "tooling_cluster" {
    source = "./cluster"
    credentials = var.credentials
    project = var.project
    cluster_name = var.cluster_name
    master_username = var.master_username
    master_password = var.master_password
}

provider "kubernetes" {
    load_config_file = false
    host = module.tooling_cluster.gke_host
    cluster_ca_certificate = base64decode(module.tooling_cluster.gke_cluster_cert)
    username = module.tooling_cluster.master_username
    password = module.tooling_cluster.master_password
}

module "jenkins" {
    source = "./tooling/jenkins"
    registry_url = data.google_container_registry_repository.registry.repository_url
    pd_name = var.pd_name
}
