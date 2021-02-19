# Template variables
variable "datacenter_name" {
    default = "tooling-dc1"
}

variable "server_replicas" {
    default = "1"
}
variable "bootstrap_expect" {
    default = "1"
}

variable "catalog_sync_enabled" {
    default = true
}
variable "catalog_sync_default" {
    default = true
}
