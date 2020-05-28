variable "project" {}
variable "credentials" {}
variable "cluster_name" {}
variable "master_username" {}
variable "master_password" {}
variable "region" {
    default = "us-central1-c"
}
variable "zone" {
    default = "us-central1-c"
}
variable "machine_type" {
    default = "n1-standard-1"
}
variable "node_count" {
    default = "2"
}
