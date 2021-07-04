expose:
  type: ingress
  ingress:
    hosts:
     core: ${host}
     notary: ${host}
  tls:
    enabled: false
    auto:
     commonName: ${host}

