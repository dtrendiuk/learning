# expose modules

module "vpc" {
  source = ".//modules/vpc"
}

module "ec2" {
  source = ".//modules/ec2"

  vpc_security_group_ids_webserver  = [module.vpc.sg_private_id]
  vpc_security_group_ids_phpmyadmin = [module.vpc.sg_private_id]
  subnet_id_webserver_1             = module.vpc.private_subnet_ids[0]
  subnet_id_webserver_2             = module.vpc.private_subnet_ids[1]
  subnet_id_phpmyadmin              = module.vpc.private_subnet_ids[0]
}
