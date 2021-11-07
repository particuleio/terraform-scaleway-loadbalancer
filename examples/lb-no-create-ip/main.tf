module "loadbalancers" {
  source = "../../"

  loadbalancers = {
    default = {
      type = "LB-S"
      name = "lb-no-create-ip"

      create_ip = false

      ip = {
        id = scaleway_lb_ip.this.id
      }
    }
  }
}

resource "scaleway_lb_ip" "this" {}

output "loadbalancers" {
  value = module.loadbalancers.this
}

terraform {
  required_providers {
    scaleway = {
      source  = "scaleway/scaleway"
      version = "~> 2.0"
    }
  }
  required_version = ">= 0.13"
}
