resource "aws_launch_template" "wordpress" {
  name_prefix   = "wordpress"
  image_id      = data.aws_ami.wordpress.id
  instance_type = "t2.micro"
}

resource "aws_autoscaling_group" "wordpress_asg" {
  availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
  capacity_rebalance  = true
  desired_capacity    = 2
  max_size            = 99
  min_size            = 1
  vpc_zone_identifier = [aws_subnet.public2.id, aws_subnet.public3.id]

  mixed_instances_policy {
    instances_distribution {
      on_demand_base_capacity                  = 0
      on_demand_percentage_above_base_capacity = 25
      spot_allocation_strategy                 = "capacity-optimized"
    }

    launch_template {
      launch_template_specification {
        launch_template_id = aws_launch_template.wordpress.id
      }

      override {
        instance_type     = "t2.micro"
        weighted_capacity = "3"
      }

      override {
        instance_type     = "t2.micro"
        weighted_capacity = "2"
      }
    }
  }
}