provider "google" {
    project = var.project
    region = var.region
    zone = var.zone
    credentials = var.credentials
}

resource "google_compute_disk" "toooling-disk" {
    lifecycle {
        prevent_destroy = true
    }
    name = "tooling-disk"
}
