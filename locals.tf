locals {
  default_loadbalancer = {
    type = "LB-S"
    tags = []
  }

  loadbalancers = {
    for name, config in var.loadbalancers :
    name => merge(local.default_loadbalancer, config)
  }
}
