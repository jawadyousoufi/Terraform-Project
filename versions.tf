terraform {
    required_version = ">0.15"
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 3.28"
        }
        cloudinit = {
            source = "hashicorp/aws"
            version = "~> 2.1"
    }
}
}

backend "remote" {
    organization = "team1"

    workspace {
        name = "terraform-project"
    }
}