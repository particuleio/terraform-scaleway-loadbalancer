resource "scaleway_lb_ip" "this" {
  for_each = {
    for loadbalancer, config in local.loadbalancers :
    loadbalancer => config
    if config.create_ip
  }
}

resource "scaleway_lb" "this" {
  for_each = local.loadbalancers

  ip_id = each.value.create_ip ? scaleway_lb_ip.this[each.key].id : data.scaleway_lb_ip.this[each.key].id
  name  = lookup(each.value, "name", null)

  type = upper(each.value["type"])

  zone       = lookup(each.value, "zone", null)
  project_id = lookup(each.value, "project_id", null)

  tags = each.value.tags
}

resource "scaleway_lb_backend" "this" {
  for_each = {
    for backend in local.backends : "${backend.loadbalancer}_${backend.name}" => backend
  }

  lb_id = scaleway_lb.this[each.value.loadbalancer].id
  name  = each.value.name

  forward_protocol       = each.value.config.forward_protocol
  forward_port           = each.value.config.forward_port
  forward_port_algorithm = lookup(each.value.config, "forward_port_algorithm", "roundrobin")

  sticky_sessions             = lookup(each.value.config, "sticky_session", "none")
  sticky_sessions_cookie_name = lookup(each.value.config, "sticky_session_cookie_name", null)

  server_ips     = lookup(each.value.config, "server_ips", [])
  proxy_protocol = lookup(each.value.config, "proxy_protocol", "none")

  timeout_server  = lookup(each.value.config, "timeout_server", null)
  timeout_connect = lookup(each.value.config, "timeout_connect", null)
  timeout_tunnel  = lookup(each.value.config, "timeout_tunnel", null)

  # TODO: Add Healthcheck support
}

resource "scaleway_lb_frontend" "this" {
  for_each = {
    for frontend in local.frontends : "${frontend.loadbalancer}_${frontend.name}" => frontend
  }

  lb_id      = scaleway_lb.this[each.value.loadbalancer].id
  backend_id = scaleway_lb_backend.this["${each.value.loadbalancer}_${each.value.config.backend_name}"].id
  name       = each.value.name

  inbound_port   = each.value.config.inbound_port
  timeout_client = lookup(each.value.config, "timeout_client", null)

  # TODO: Add Certificate support
  dynamic "acl" {
    for_each = lookup(each.value.config, "acls", [])

    content {
      action {
        type = acl.value.action_type
      }
      match {
        ip_subnet         = lookup(acl.value.match, "ip_subnet", null)
        http_filter       = lookup(acl.value.match, "http_filter", null)
        http_filter_value = lookup(acl.value.match, "http_filter_value", null)
        invert            = lookup(acl.value.match, "invert", false)
      }
    }
  }
}
