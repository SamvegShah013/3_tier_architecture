# Create EC2 AutoScaling Group - app
resource "aws_autoscaling_group" "three_tier_app_asg" {
  name = "three_tier_app_asg"
  launch_template {
    id      = aws_launch_template.three_tier_app_ltemplate.id
    version = "$Latest"
  }
  vpc_zone_identifier = [aws_subnet.privat_sub_3.id, aws_subnet.privat_sub_4.id]
  min_size            = 2
  max_size            = 3
  desired_capacity    = 2
}

# Create Launch Template - app
resource "aws_launch_template" "three_tier_app_ltemplate" {
  name_prefix            = "three_tier_app_ltemplate"
  image_id               = "ami-0327f51db613d7bd2"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.three_tier_sg.id]
  key_name               = "3_tier"
  user_data              = filebase64("../scripts/backend.sh")
}
