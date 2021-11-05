variable "loadbalancers" {
  type        = map(any)
  description = "The Scaleway Load Balancers configurations"
}

variable "region" {
  type        = string
  description = "Region to be used with the Scaleway provider"
  default     = "fr-par"
}

variable "zone" {
  type        = string
  description = "Zone to be used with the Scaleway provider"
  default     = "fr-par-1"
}
