locals {
  default_loadbalancer = {
    type      = "LB-S"
    tags      = []
    backends  = []
    frontends = []
    create_ip = true
    ip        = {}

    certificates = []
  }

  loadbalancers = {
    for name, config in var.loadbalancers :
    name => merge(local.default_loadbalancer, config)
  }

  backends = flatten([
    for name, config in local.loadbalancers : [
      for backend in config.backends : {
        name         = backend.name
        loadbalancer = name
        config       = backend
      }
    ]
  ])
  frontends = flatten([
    for name, config in local.loadbalancers : [
      for frontend in config.frontends : {
        name         = frontend.name
        loadbalancer = name
        config       = frontend
      }
    ]
  ])
  certificates = flatten([
    for name, config in local.loadbalancers : [
      for certificate in config.certificates : {
        name         = certificate.name
        loadbalancer = name
        config       = certificate
      }
    ]
  ])
}
