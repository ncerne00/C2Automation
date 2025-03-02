provider "aws" {
  region = var.aws_region
}

module "c2_server" {
  source = "./modules/c2_server"

  ami                       = var.c2_ami
  instance_type             = var.c2_instance_type
  c2_traffic_ingress_ports  = var.c2_traffic_ingress_ports
  c2_framework              = "sliver"
  c2_traffic_sg_id          = module.networking.c2_traffic_sg_id
  ssh_sg_id                 = module.networking.ssh_sg_id
}

module "c2_redirectors" {
  source = "./modules/c2_redirectors"

  ami                 = var.c2_redirector_ami
  instance_type       = var.c2_redirector_instance_type
  c2_redirector_sg_id = module.networking.c2_redirector_sg_id
}

module "dns" {
  source = "./modules/dns"

  domain = var.domain
  c2_domain = var.c2_domain
  redirector_public_ip = module.c2_redirectors.c2_redirector_public_ip
  c2_public_ip = module.c2_server.c2_server_public_ip
}

module "networking" {
  source = "./modules/networking"

  c2_traffic_allowed_ips = var.c2_traffic_ingress_ports
  c2_traffic_ingress_ports = var.c2_traffic_ingress_ports
  redirector_public_ip = module.c2_redirectors.c2_redirector_public_ip
  ssh_allowed_ips = var.ssh_allowed_ips
}