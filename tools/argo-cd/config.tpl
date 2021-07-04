installCRDs: ${install_crd}
nameOverride: ${name_override}
global:
  image:
    tag: ${argo_cd_version}
dex:
  enabled: ${dex_enabled}
server:
  extraArgs:
    - ${extra_args}
