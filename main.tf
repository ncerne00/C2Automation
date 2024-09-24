provider "aws" {
  region = var.aws_region
}

module "attack_infrastructure" {
  source = "./modules/attack_infrastructure"

  name                 = var.name
  aws_region           = var.aws_region
  vpc_cidr             = var.vpc_cidr
  public_subnets_cidr  = var.public_subnets_cidr
  private_subnets_cidr = var.private_subnets_cidr
}
