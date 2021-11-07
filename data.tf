data "scaleway_lb_ip" "this" {
  for_each = {
    for loadbalancer, config in local.loadbalancers :
    loadbalancer => config
    if !config.create_ip
  }

  ip_address = lookup(each.value.ip, "address", null)
  ip_id      = lookup(each.value.ip, "id", null)
}
