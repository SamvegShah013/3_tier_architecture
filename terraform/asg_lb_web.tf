# Create EC2 AutoScaling Group - web
resource "aws_autoscaling_group" "three_tier_web_asg" {
  name = "three-tier-web-asg"
  launch_template {
    id      = aws_launch_template.three_tier_web_ltemplate.id
    version = "$Latest"
  }
  vpc_zone_identifier = [aws_subnet.pub_sub_1.id, aws_subnet.pub_sub_2.id]
  min_size            = 2
  max_size            = 3
  desired_capacity    = 0
  target_group_arns   = [aws_lb_target_group.three_tier_web_lb_tg.arn]
}

# Create Launch Template - web
resource "aws_launch_template" "three_tier_web_ltemplate" {
  name_prefix            = "three_tier_web_ltemplate"
  image_id               = "ami-0327f51db613d7bd2"
  instance_type          = "t2.micro"
  key_name               = "3_tier"
  vpc_security_group_ids = [aws_security_group.three_tier_sg.id]
user_data = filebase64("../scripts/frontend.sh")

}

# Create LoadBalancer - web
resource "aws_lb" "three_tier_web_lb" {
  name               = "three-tier-web-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.web_lb_sg.id]
  subnets            = [aws_subnet.pub_sub_1.id, aws_subnet.pub_sub_2.id]

  tags = {
    Environment = "three_tier_web_lg"
  }
}

# Create LoadBalancer target group - web
resource "aws_lb_target_group" "three_tier_web_lb_tg" {
  name     = "three-tier-web-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.three_tier_vpc.id
  health_check {
    interval            = 30
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 10
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }
}

# Create LoadBalancer listener - web
resource "aws_lb_listener" "three_tier_web_lb_listener" {
  load_balancer_arn = aws_lb.three_tier_web_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.three_tier_web_lb_tg.arn
  }
}


