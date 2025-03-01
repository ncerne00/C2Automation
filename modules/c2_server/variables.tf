variable "ami" {
  description = "ID of AMI to use for the c2 instance."
  type        = string
}

variable "instance_type" {
    description = "Size of the c2 instance."
    type        = string
}

variable "c2_framework" {
    description = "The framework to use for the c2 instance."
    type        = string
}

variable "c2_traffic_ingress_ports" {
    description = "List of allowed inbound ports for the C2 server"
    type        = list(number)
}

variable "allowed_ips" {
  description = "List of allowed IPs for inbound C2 traffic."
  type        = list(string)
  }