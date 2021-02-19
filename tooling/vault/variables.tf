variable "project" {}

variable "key_ring"{
    default = "vault-unseal-kr"
}
variable "crypto_key" {
    default = "vault-unseal-key"
}

variable "keyring_location" {
    default = "global"
}

variable "service_account_email" {
    default = "1030028120991-compute@developer.gserviceaccount.com"
}
