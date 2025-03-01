variable "c2_traffic_ingress_ports" {
    description = "List of allowed inbound ports for the C2 server"
    type        = list(number)
}

variable "c2_traffic_allowed_ips" {
  description = "List of allowed IPs for inbound C2 traffic."
  type        = list(string)
  }

  variable "ssh_allowed_ips" {
    description = "List of allowed IPs for SSH access."
    type        = list(string)
    default     = null
}