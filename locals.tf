locals {
  default_loadbalancer = {
    type      = "LB-S"
    tags      = []
    backends  = []
    create_ip = true
    ip        = {}
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
}
