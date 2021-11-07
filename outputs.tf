output "this" {
  value = {
    for loadbalancer, config in local.loadbalancers :
    loadbalancer => {
      lb    = scaleway_lb.this[loadbalancer]
      lb_ip = config.create_ip ? scaleway_lb_ip.this[loadbalancer] : data.scaleway_lb_ip.this[loadbalancer]

      backends = [
        for backend in config.backends :
        scaleway_lb_backend.this["${loadbalancer}_${backend.name}"]
      ]
    }
  }
  description = "Map of every Load Balancer configuration: LBs, LB IPs, Backends"
}

output "loadbalancers" {
  value       = scaleway_lb.this
  description = "The Scaleway Load Balancer resources"
}

output "loadbalancer_backends" {
  value       = scaleway_lb_backend.this
  description = "The Scaleway Load Balancer Backends"
}
