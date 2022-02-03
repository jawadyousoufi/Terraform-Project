resource "aws_lb" "wp_lb" {
  name               = "wp_lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = [for subnet in aws_subnet.public : subnet.id]

  #enable_deletion_protection = true
#  access_logs {
#     bucket  = aws_s3_bucket.lb_logs.bucket
#     prefix  = "test-lb"
#     enabled = true
#   }

  tags = {
     Name = "project1"
    Team = "ProTeam"
    Env  = "Dev"
  }
}

# Create a new ALB Target Group attachment
# resource "aws_autoscaling_attachment" "asg_attachment_project1" {
#   autoscaling_group_name = aws_autoscaling_group.wordpress_asg.id
#   alb_target_group_arn   = aws_lb_target_group.test.arn
# }