variable "domain" {
    description = "The root domain to use for your infrastructure."
    type        = string
}

variable "redirector_domain" {
    description = "The domain to use for the redirector instance."
    type        = string
}

variable "c2_domain" {
    description = "The domain to use for the c2 instance."
    type        = string
}

variable "redirector_public_ip" {
    description = "Public IP for the redirector server."
    type        = string
}

variable "c2_public_ip" {
    description = "Public IP for the c2 server."
    type        = string
}