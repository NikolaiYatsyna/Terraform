server:

  affinity: |
    podAntiAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
        - labelSelector:
            matchLabels:
              app: {{ template "vault.name" . }}
              release: "{{ .Release.Name }}"
              component: server
          topologyKey: kubernetes.io/hostname

  service:
    enabled: true

  ha:
    enabled: true
    replicas: 1
    config: |
      ui = true

      listener "tcp" {
        tls_disable = 1
        address = "[::]:8200"
        cluster_address = "[::]:8201"
      }

      storage "consul" {
        path = "vault"
        address = "HOST_IP:8500"
      }

      service_registration "kubernetes" {}

      seal "gcpckms" {
         project     = "${project}"
         region      = "${keyring_location}"
         key_ring    = "${key_ring}"
         crypto_key  = "${crypto_key}"
      }
ui:
  enabled: true
  serviceType: 'LoadBalancer'
  externalPort: 80
