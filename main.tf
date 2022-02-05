module "autoscaling" {
    source = "/home/ec2-user/Terraformaws/autoscalling"
    namespace = var.namespace
    ssh_keypair = var.ssh_keypair

    vpc = module.networking.vpc
    sg  = module.networking.sg
    db_config = module.networking.db_config
}

module "database"{
    source = "/home/ec2-user/Terraformaws/database"
    namespace = var.namespace

    vpc = module.networking.vpc
    sg  = module.networking.sg    
}

module "networking"{
    source = "/home/ec2-user/Terraformaws/networking"
    namespace = var.namespace
}