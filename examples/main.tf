module "loadbalancers" {
  source = "../"

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
    }
  }
}

output "loadbalancers" {
  value = module.loadbalancers.this
}
