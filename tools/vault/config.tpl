ui:
  enabled: true
  serviceType: 'ClusterIP'

global:
  enabled: true
server:
  dev:
    enabled: false
  extraEnvironmentVars:
    VAULT_DEV_LISTEN_ADDRESS: 0.0.0.0:8200
    VAULT_ADDR: http://0.0.0.0:8200
  ingress:
    enabled: true
    annotations: |
       'kubernetes.io/ingress.class': "nginx"
       'kubernetes.io/tls-acme': "true"
    hosts:
     - host: ${host}

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
    replicas: ${server_replicas}
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
