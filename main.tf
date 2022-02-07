module "autoscaling" {
    source = "/home/ec2-user/Terraform-Project/autoscalling"
    namespace = var.namespace
    ssh_keypair = var.ssh_keypair

    vpc = module.networking.vpc
    sg  = module.networking.sg
}

module "database"{
    source = "/home/ec2-user/Terraform-Project/database"
    namespace = var.namespace

    vpc = module.networking.vpc
    sg  = module.networking.sg    
}

module "networking"{
    source = "/home/ec2-user/Terraform-Project/networking"
    namespace = var.namespace
}