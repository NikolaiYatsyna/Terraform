global:
  name: ${name}
  datacenter: ${datacenter_name}
server:
  replicas: ${server_replicas}
  bootstrapExpect: ${bootstrap_expect}
syncCatalog:
    enabled: ${catalog_sync_enabled}
    default: ${catalog_sync_default}
ui:
  service:
    type: 'ClusterIP'
  ingress:
    enabled: true
    hosts:
     - host: ${host}
       paths:
         - /
         - /ui
         - /v1

    annotations: |
        'kubernetes.io/ingress.class': "nginx"
        'nginx.ingress.kubernetes.io/force-ssl-redirect': "true"
