# module "iam_instance_profile" {
#   source  = "terraform-aws-modules/iip/aws"
#   actions = ["logs:*" , "rds:*"]
# }
# data "cloudinit_config" "config" {
#     gzip = true
#     base64_encode = true
#     part {
#         content_type = "text/cloud-config"
#         content = templatefile("${path.module}/cloud_config.yaml")
#     }
# }

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
    name_prefix = var.namespace
    image_id = data.aws_ami.centos.id
    instance_type = "t2.micro"
    user_data = filebase64("/home/ec2-user/Terraformaws/autoscalling/wordpress.sh")
    key_name = var.ssh_keypair
    # iam_instance_profile {
    #   name = module.iam_instance_profile.name
    # }
    vpc_security_group_ids = [aws_security_group.allow_tls.id]
}
resource "aws_autoscaling_group" "webserver" {
  name                      = "${var.namespace}-asg"
  max_size                  = 6
  min_size                  = 4
  vpc_zone_identifier       = var.vpc.public_subnets
  target_group_arns         =  module.alb.target_group_arns
  launch_template {
      id = aws_launch_template.webserver.id
      version = aws_launch_template.webserver.latest_version
  }
}
module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 5.0"

  name = var.namespace

  load_balancer_type = "application"

  vpc_id             = var.vpc.vpc_id
  subnets            = var.vpc.public_subnets
  security_groups    = [var.sg.lb]
  http_tcp_listeners = [
      {
          port= 80,
          protocol = "HTTP"
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
  ]
}
resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = "vpc-01e012999ca1ca11e"

  ingress {
    description      = "TLS from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]

  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}