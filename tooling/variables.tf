variable "credentials" {}
variable "master_username" {}
variable "master_password" {}
variable "project" {
    default = "stoked-monitor-275907"
}

variable "region" {
    default = "us-central1-c"
}
variable "zone" {
    default = "us-central1-c"
}

variable "cluster_name" {
    default = "tooling-cluster"
}

variable "instance_machine_type" {
    default = "n1-standard-1"
}

variable "node_count" {
    default = "2"
}

variable "gcr_region" {
    default = "us"
}
variable "jenkins_docker_image" {
    default = "jenkins-master"
}

variable "jenkins_docker_image_version" {
    default = "latest"
}

variable "pd_name" {
    default = "tooling-disk"
}

variable "static_ip_resource_name" {
    default = "tooling-global-ip"
}
