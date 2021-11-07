# terraform-scaleway-loadbalancer

Terraform module to create and manage Scaleway Loadbalancers.

## Usage


### Examples

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
