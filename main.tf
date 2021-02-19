provider "google" {
    alias = "gcp"
    project = var.project
    region = var.region
    zone = var.zone
    credentials = var.credentials
}

provider "kubernetes" {
    alias = "gke"
    load_config_file = false
    host = module.tooling_cluster.gke_host
    cluster_ca_certificate = base64decode(module.tooling_cluster.gke_cluster_cert)
    username = module.tooling_cluster.master_username
    password = module.tooling_cluster.master_password
}

provider "helm" {
    alias = "helm"
    kubernetes {
        host = module.tooling_cluster.gke_host
        username = module.tooling_cluster.master_username
        password = module.tooling_cluster.master_password
        cluster_ca_certificate =  base64decode(module.tooling_cluster.gke_cluster_cert)
    }
}

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
    providers = {
        google = google.gcp
    }
}


//module "jenkins" {
//    source = "./tooling/jenkins"
//    registry_url = data.google_container_registry_repository.registry.repository_url
//    providers = {
//        google = google.gcp
//        kubernetes = kubernetes.gke
//    }
//}
//
module "consul" {
    source = "./tooling/consul"
    providers = {
        helm = helm.helm
    }
}

module "vault" {
    source = "./tooling/vault"
    project = var.project
    providers = {
        google = google.gcp
        helm = helm.helm
    }
}
