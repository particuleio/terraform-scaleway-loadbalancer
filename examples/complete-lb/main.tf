module "loadbalancers" {
  source = "../../"

  loadbalancers = {
    default = {
      type = "LB-S"
      name = "default-lb"
      backends = [
        {
          name             = "sample-test"
          forward_port     = 80
          forward_protocol = "http"
        }
      ]
      frontends = [
        {
          name         = "sample-frontend"
          inbound_port = 80
          backend_name = "sample-test"
        }
      ]
    }
  }
}

output "loadbalancers" {
  value = module.loadbalancers.this
}
