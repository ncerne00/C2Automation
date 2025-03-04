variable "ami" {
  description = "ID of AMI to use for the c2 instance."
  type        = string
}

variable "instance_type" {
    description = "Size of the c2 instance."
    type        = string
}

variable "c2_redirector_sg_id" {
    description = "Security group handling traffic for the C2 redirector."
    type        = string
}

variable "ssh_sg_id" {
    description = "Security group handling SSH traffic."
    type        = string
}

variable "certbot_sg_id" {
    description = "Security group handling certbot traffic."
    type        = string
}

variable "key_pair" {
    description = "Name of the key pair to use for the redirector instance."
    type        = string
}

variable "c2_server_ip_address" {
    description = "Public IP for the c2 server."
    type        = string
}

variable "redirector_domain_name" {
    description = "The domain to use for the redirector instance."
    type        = string
}

variable "approved_user_agent" {
    description = "The user agent to use for the redirector instance."
    type        = string
}