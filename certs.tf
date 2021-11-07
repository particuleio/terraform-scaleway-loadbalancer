resource "scaleway_lb_certificate" "this" {
  for_each = {
    for certificate in local.certificates :
    "${certificate.loadbalancer}_${certificate.name}" => certificate
  }

  lb_id = scaleway_lb.this[each.value.loadbalancer].id
  name  = each.value.name

  # TODO: Ensure the certificates are working properly
  dynamic "letsencrypt" {
    for_each = lookup(each.value.config, "letsencrypt", null) != null ? [1] : []

    content {
      common_name = each.value.config.letsencrypt.common_name

      subject_alternative_name = lookup(each.value.config.letsencrypt, "subject_alternative_name", [])
    }
  }

  dynamic "custom_certificate" {
    for_each = lookup(each.value.config, "custom_certificate", null) != null ? [1] : []

    content {
      certificate_chain = each.value.config.custom_certificate.certificate_chain
    }
  }
}
