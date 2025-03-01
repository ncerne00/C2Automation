provider "aws" {
  region = var.aws_region
}

module "c2_server" {
  source = "./modules/c2_server"

  ami                       = var.c2_ami
  instance_type             = var.c2_instance_type
  c2_traffic_ingress_ports  = var.c2_traffic_ingress_ports
  allowed_ips               = var.allowed_ips
  c2_framework              = "sliver"
}

module "c2_redirector" {
  source = "./modules/c2_redirector"

  ami                 = var.c2_redirector_ami
  instance_type       = var.c2_redirector_instance_type
}