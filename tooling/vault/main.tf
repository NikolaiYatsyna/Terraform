data "template_file" "vault-template" {
    template = file("./tooling/vault/config.tpl")
    vars = {
        project = var.project
        key_ring = var.key_ring
        crypto_key = var.crypto_key
        keyring_location = var.keyring_location
    }
}

//resource "google_kms_key_ring" "key_ring" {
//    project  = var.project
//    name     = var.key_ring
//    location = var.keyring_location
//}
//
//resource "google_kms_crypto_key" "crypto_key" {
//    name            = var.crypto_key
//    key_ring        = google_kms_key_ring.key_ring.self_link
//    rotation_period = "100000s"
//}

resource "helm_release" "vault-server" {
    repository = "https://helm.releases.hashicorp.com"
    chart = "vault"
    name = "tooling-vault"
    values = [data.template_file.vault-template.rendered]
}
