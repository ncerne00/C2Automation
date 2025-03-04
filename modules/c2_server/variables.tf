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

variable "c2_traffic_sg_id" {
    description = "Security group handling traffic for the C2 server."
    type        = string
}

variable "ssh_sg_id" {
    description = "Security group handling SSH traffic."
    type        = string
}

variable "key_pair" {
    description = "Name of the key pair to use for the c2 instance."
    type        = string
}

variable "volme_size" {
    description = "Size of the volume to attach to the c2 instance."
    type        = number
}