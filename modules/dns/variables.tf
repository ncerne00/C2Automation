variable "domain" {
    description = "The root domain to use for your infrastructure."
    type        = string
}

variable "c2_domain" {
    description = "The domain to use for the c2 instance."
    type        = string
}

variable "c2_server_dns_record" {
    description = "DNS record for the c2 server."
    type        = string
}

variable "c2_redirector_dns_record" {
    description = "DNS record for the c2 redirector"
    type        = string
}