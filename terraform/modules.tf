module "network" {
  source = "./modules/network"

  project_name        = var.project_name
  tags                = var.tags
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidrs = var.public_subnet_cidrs
}

module "compute" {
  source = "./modules/compute"

  project_name = var.project_name
  tags         = var.tags
  vpc_id       = module.network.vpc_id
  subnet_ids   = module.network.public_subnet_ids
}
