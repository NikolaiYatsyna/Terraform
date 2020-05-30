global:
  datacenter: ${datacenter_name}
server:
  replicas: ${server_replicas}
  bootstrapExpect: ${bootstrap_expect}
syncCatalog:
    enabled: ${catalog_sync_enabled}
    default: ${catalog_sync_default}
ui:
  service:
    type: 'LoadBalancer'
