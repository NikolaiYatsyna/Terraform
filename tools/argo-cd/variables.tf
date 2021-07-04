variable "argo_cd_version" {
  default = "v1.8.4"
}

variable "extra_args" {
  default = "--insecure"
}

variable "dex_enabled" {
  default = false
}

variable "install_crd" {
  default = false
}

variable "namespace" {}
variable "sub_domain" {}
