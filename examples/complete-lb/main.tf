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
          acls = [
            {
              action_type = "deny"
              match = {
                ip_subnet         = ["51.51.51.51"]
                http_filter       = "regex"
                http_filter_value = ["^foo*bar$"]
              }
            }
          ]
        }
      ]
    }
  }
}

output "loadbalancers" {
  value = module.loadbalancers.this
}
