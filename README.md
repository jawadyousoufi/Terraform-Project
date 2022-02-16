# AWS Three-tier Architecture Using Terraform

This project builds a three-tier network configuration in AWS.We will create a total of 46 AWS resources through Terraform, including;

* Creates a VPC provided in the region 
* Creates subnets for each layer
* Creates an IGW and NAT gateway
* Creates Route tables
* Creates a RDS instance
* Configures security group for Web layer
* EC2 instances for webservers
* Application load balancer
* Route53

### Table of Contents

* [Architecture](https://github.com/dskz/project1_v2#architecture)
 
* [Prerequisites](https://github.com/dskz/project1_v2#prerequisites) 
 
* [Provider](https://github.com/dskz/project1_v2#providertf)  
 
* [Virtual Private Cloud](https://github.com/dskz/project1_v2#vpctf)  
 
* [Auto Scaling Group/Load Balancer](https://github.com/dskz/project1_v2#asgtf) 
 
* [Database](https://github.com/dskz/project1_v2#dbtf) 
 
* [Route53](https://github.com/dskz/project1_v2#route53tf)  
 
* [Variables](https://github.com/dskz/project1_v2#variabletf) 
 
* [DB Userdata](https://github.com/dskz/project1_v2#wordpresssh)  
  
* [Initilazing the Terraform](https://github.com/dskz/project1_v2#initilazing-the-terraform)
 
* [Deleting the Resources](https://github.com/dskz/project1_v2#deleting-the-resources) 

* [Notes](https://github.com/dskz/project1_v2#notes)  
 
## Architecture

![alt text](https://user-images.githubusercontent.com/92490823/153505957-6c81aa4b-4b09-4bdb-9c59-e6f9cce9a273.png "AWS Three-tier Architecture")

## Prerequisites

1. The AWS CLI configured with AWS account credentials, and a familiarity with AWS cloud architecture
2. Terraform installed on your home system
3. A text editor such as Atom, Visual Studio Code, or PyCharm, with the Terraform plug-in installed
4. Create a new directory for the four Terraform source files we will be working with: provider.tf,vpc.tf, asg.tf, db.tf, route53.tf variable.tf and wordpress.sh

## provider.tf

AWS will be our plug-in provider, so the top of provider.tf should include:

```
provider "aws" {
  region = var.region
}
```

## vpc.tf

This code will create a VPC along with 3 Public and 6 Private subnets, IGW to Public Subnets and NG to Private Subnets. Route Tables to configure traffic for Subnets and Security Groups. Security Groups which will set of firewall rules for Load Balancer, Database and Server. It will open neccesary ports to control the traffic to your Load Balancer through your VPC

```
data "aws_availability_zones" "available" {}
module "vpc" {
  source                       = "terraform-aws-modules/vpc/aws"
  version                      = "2.64.0"
  name                         = "${var.namespace}-my-vpc"
  cidr                         = "10.0.0.0/16"
  azs                          = data.aws_availability_zones.available.names
  private_subnets              = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets               = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  database_subnets             = ["10.0.21.0/24", "10.0.22.0/24", "10.0.23.0/24"]
  create_database_subnet_group = true
  enable_nat_gateway           = true
  map_public_ip_on_launch      = true
}
module "lb_sg" {
  source = "terraform-in-action/sg/aws"
  vpc_id = module.vpc.vpc_id
  ingress_rules = [{
    port        = 80
    cidr_blocks = ["0.0.0.0/0"]
  }]
}
module "websvr_sg" {
  source = "terraform-in-action/sg/aws"
  vpc_id = module.vpc.vpc_id
  ingress_rules = [
    {
      port            = 8080
      security_groups = [module.lb_sg.security_group.id]
    },
    {
      port        = 22
      cidr_blocks = ["10.0.0.0/16"]
    }
  ]
}
module "db_sg" {
  source = "terraform-in-action/sg/aws"
  vpc_id = module.vpc.vpc_id
  ingress_rules = [
    {
      port            = 3306
      port            = 80
      security_groups = [module.websvr_sg.security_group.id]
  }]
}

```

## asg.tf

Load Balancer works with launch template Auto Scaling Group to distribute incoming traffic across your targets to Servers (healthy Amazon EC2 instances) and Database. This increases the scalability and availability of your application. You can enable Load Balancer within multiple availability zones to increase the fault tolerance of your applications.

```   
data "aws_ami" "centos" {
  owners      = ["125523088429"]
  most_recent = true
  filter {
    name   = "name"
    values = ["CentOS 7.9.2009 *"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}
resource "aws_launch_template" "webserver" {
  name_prefix   = "${var.namespace}-template"
  image_id      = data.aws_ami.centos.id
  instance_type = "t2.micro"
  user_data     = filebase64("/home/ec2-user/project1_v2/wordpress.sh")
  key_name      = var.ssh_keypair

  vpc_security_group_ids = [aws_security_group.allow_tls.id]
}
resource "aws_autoscaling_group" "webserver" {
  name                = "${var.namespace}-asg"
  max_size            = 99
  min_size            = 1
  vpc_zone_identifier = module.vpc.public_subnets
  target_group_arns   = module.alb.target_group_arns
  launch_template {
    id      = aws_launch_template.webserver.id
    version = aws_launch_template.webserver.latest_version
  }
}
module "alb" {
  source             = "terraform-aws-modules/alb/aws"
  version            = "~> 5.0"
  name               = "${var.namespace}-alb"
  load_balancer_type = "application"
  vpc_id             = module.vpc.vpc_id
  subnets            = module.vpc.public_subnets
  security_groups    = [module.lb_sg.security_group.id]
  http_tcp_listeners = [
    {
      port               = 80,
      protocol           = "HTTP"
      target_group_index = 0
    }
  ]
  target_groups = [
    {
      name_prefix      = "websvr"
      backend_protocol = "HTTP"
      backend_port     = 8080
      target_type      = "instance"
    }
}

```

## db.tf

Database hosted inside private subnets to ensure high availability.Security group inbound rules only allow port 3306 for web tier.

```
resource "random_password" "password" { #A
  length           = 16
  special          = true
  override_special = "_%@/'\""
}
resource "aws_db_instance" "default" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t2.micro"
  identifier           = "${var.namespace}dbinstance"
  name                 = "${var.namespace}dbinstance"
  username             = "admin"
  password             = "password"
  db_subnet_group_name = module.vpc.database_subnet_group
  vpc_security_group_ids = [module.lb_sg.security_group.id]
  skip_final_snapshot  = true
}
```
## route53.tf

```
resource "aws_route53_record" "www" {
zone_id = var.zone_id
name    = "wordpress."
type    = "CNAME"
ttl     = "300"
records = [aws_db_instance.default.address]
}
```

## route53.tf

Route53 records let you route traffic to selected AWS resources inside the VPC

```
resource "aws_route53_record" "www" {
zone_id = var.zone_id
name    = "wordpress."
type    = "CNAME"
ttl     = "300"
records = [aws_db_instance.default.address]
}
```

## variable.tf

Variables allow you to write configuration that is flexible and easier to re-use. In this code you will find variables for namespace, region, ssh_keypair , cluster_engine.

```
variable "namespace" {
  description = "The project namespace for resource naming"
  default     = "threetier"
}
variable "region" {
  description = "AWS region"
  default     = "us-east-1"
}
variable "ssh_keypair" {
  description = "SSH keypair to use for autoscaling"
  default     = null
  type        = string
}
variable "cluster_engine" {
  description = "Aurora cluster engine"
  type        = string
  default     = "MySQL"
}
```

## wordpress.sh

This code is userdata for creating database instance

```
#!/bin/bash
# Install necessary tools
sudo yum install httpd wget unzip epel-release mysql -y
sudo yum -y install https://rpms.remirepo.net/enterprise/remi-release-7.rpm
sudo yum-config-manager --enable remi-php74
sudo yum install php -y
sudo yum install php-mysql -y
# Download latest wordpress
sudo wget https://wordpress.org/latest.tar.gz
sudo tar -xf latest.tar.gz -C /var/www/html/
sudo mv /var/www/html/wordpress/* /var/www/html/
sudo getenforce
sudo sed 's/SELINUX=permissive/SELINUX=enforcing/g' /etc/sysconfig/selinux -i
sudo setenforce 0
sudo chown -R apache:apache /var/www/html/
sudo systemctl start httpd
sudo systemctl enable httpd

```

## Initilazing the Terraform

To install and create the resources: 1-Before creating all so you need to initialise Terraform which needs to be done only once in a folder.Initialise Terraform with the following command:

```
terraform init

```
You can check any syntax by using:

```
terraform validate 

```
You can see all changes on terraform plan then create with terraform apply commands:

```
terraform plan  --auto-approve
terraform apply --auto-approve
```

## Deleting the Resources

To delete the Application:

```
terraform destroy 

```

### Notes

*  Please make sure modify correct path of user_data under webserver aws launch template resources in asg.tf
*  Default region is "us-east-1". Modify the default region in provider.tf

