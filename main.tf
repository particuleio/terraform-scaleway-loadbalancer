resource "scaleway_lb_ip" "this" {
  for_each = local.loadbalancers
}

resource "scaleway_lb" "this" {
  for_each = local.loadbalancers

  ip_id = scaleway_lb_ip.this[each.key].id
  name  = lookup(each.value, "name", null)

  type = upper(each.value["type"])

  zone       = lookup(each.value, "zone", null)
  project_id = lookup(each.value, "project_id", null)

  tags = lookup(each.value, "tags", null)
}
