# terraform-scaleway-loadbalancer

[![terraform-scaleway-loadbalancer](https://github.com/particuleio/terraform-scaleway-loadbalancer/actions/workflows/terraform.yml/badge.svg)](https://github.com/particuleio/terraform-scaleway-loadbalancer/actions/workflows/terraform.yml)

Terraform module to create and manage [Scaleway Load Balancers][scw-lb-main].

This module creates and configures the following resources:
- [Scaleway Load Balancers][scw-lb]
- [Scaleway Load Balancer IPs][scw-lb-ip]
- [Scaleway Load Balancer Certificates][scw-lb-certs]
- [Scaleway Load Balancer Frontends][scw-lb-f]
- [Scaleway Load Balancer Backends][scw-lb-b]

[scw-lb-main]: https://www.scaleway.com/en/load-balancer/
[scw-lb]: https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/lb
[scw-lb-b]: https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/lb_backend
[scw-lb-certs]: https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/lb_certificate
[scw-lb-f]: https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/lb_frontend
[scw-lb-ip]: https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/lb_ip

It allows to define multiple Load Balancers using a `map` of Load Balancer
definitions.

Every output is available at the Load Balancer definition scope in the
`output.this` Terraform Output.

This module supports Managed Load Balancer IPs (created using this module)
as well as Non-Managed Load Balancer IPs by setting the `create_ip` Load Balancer
attribute to `false` and by passing the corresponding information in the `ip`
attribute that matches the ones in the [Scaleway Load Balancer IP Datasource][scw-lb-data-ip]

[scw-lb-data-ip]: https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/data-sources/lb_ip

## Usage

```hcl
module "loadbalancers" {
  source = "particuleio/loadbalancer/scaleway"

  loadbalancers = {
    # define each Load Balancer in the `loadbalancers` map.
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
          backend_name = "sample-test"  # match the backend name
        }
      ]
    }
  }
}
```


### Examples

Examples are available in the `./examples/` directory.

- [Complete Load Balancer](./examples/complete-lb/)
- [Load Balancer No Create IP](./examples/lb-no-create-ip/)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_scaleway"></a> [scaleway](#requirement\_scaleway) | ~> 2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_scaleway"></a> [scaleway](#provider\_scaleway) | ~> 2.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [scaleway_lb.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/lb) | resource |
| [scaleway_lb_backend.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/lb_backend) | resource |
| [scaleway_lb_certificate.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/lb_certificate) | resource |
| [scaleway_lb_frontend.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/lb_frontend) | resource |
| [scaleway_lb_ip.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/lb_ip) | resource |
| [scaleway_lb_ip.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/data-sources/lb_ip) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_loadbalancers"></a> [loadbalancers](#input\_loadbalancers) | The Scaleway Load Balancers configurations | `map(any)` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Region to be used with the Scaleway provider | `string` | `"fr-par"` | no |
| <a name="input_zone"></a> [zone](#input\_zone) | Zone to be used with the Scaleway provider | `string` | `"fr-par-1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_loadbalancer_backends"></a> [loadbalancer\_backends](#output\_loadbalancer\_backends) | The Scaleway Load Balancer Backends |
| <a name="output_loadbalancer_frontends"></a> [loadbalancer\_frontends](#output\_loadbalancer\_frontends) | The Scaleway Load Balancer Frontends |
| <a name="output_loadbalancers"></a> [loadbalancers](#output\_loadbalancers) | The Scaleway Load Balancer resources |
| <a name="output_this"></a> [this](#output\_this) | Map of every Load Balancer configuration: LBs, LB IPs, Backends, Frontends, Certificates |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
