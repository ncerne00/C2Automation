/* Variables to manage the C2 server */
variable "c2_ami" {
  description = "ID of AMI to use for the c2 instance."
  type        = string
  default     = "ami-05b10e08d247fb927" // Amazon Linux 2
}

variable "c2_instance_type" {
    description = "Size of the c2 instance."
    type        = string
    default     = "t2.medium"
}

variable "c2_framework" {
    description = "The framework to use for the c2 instance."
    type        = string
    default     = "sliver"
}

variable "c2_domain" {
    description = "The domain to use for the c2 instance."
    type        = string
    default     = "c2"
}

variable "c2_traffic_ingress_ports" {
  description = "List of allowed inbound ports for the C2 server."
  type        = list(number)
  default     = [8888, 443, 53]
}

/* Variables to manage the C2 redirectors */
variable "enable_redirector" {
  description = "Deploy a redirector in front of the C2 server."
  type        = bool
  default     = true
}

variable "c2_redirector_ami" {
  description = "ID of AMI to use for the c2 redirector instances."
  type        = string
  default     = "ami-05b10e08d247fb927" // Amazon Linux 2
}

variable "c2_redirector_instance_type" {
    description = "Size of the c2 redirector instance."
    type        = string
    default     = "t2.micro"
}

/* General variables to manage infrastructure */
variable "aws_region" {
    description = "Region to use for the instances."
    type        = string
    default     = "us-east-1"
}

variable "domain" {
    description = "The root domain to use for your infrastructure."
    type        = string
    default     = null
}

variable "ssh_allowed_ips" {
    description = "List of allowed IPs for SSH access."
    type        = list(string)
    default     = null
}